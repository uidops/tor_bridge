#!/bin/sh

printf "Torproject bridges "

if [ "$1" = "obfs4"  ];
then
    url="https://bridges.torproject.org/bridges?transport=obfs4"
    printf "[type: obfs4]\n"
else
    url="https://bridges.torproject.org/bridges?transport=0"
    printf "[type: none]\n"
fi

get_request=$(curl -X GET -s $url)
key=$(echo $get_request | tr " " "\n" | grep 'value=\"' | sed -e 's/value="/\ /;s/" /\ /;s/^ //;s/">//')
img=$(echo $get_request | tr " " "\n" | grep 'src="data:image/jpeg;base64' | sed -e 's/src="data:image\/jpeg;base64,//;s/">$//')

echo $img > /tmp/torbridge.txt
base64 -d /tmp/torbridge.txt > /tmp/torbridge.jpg

feh /tmp/torbridge.jpg & >/dev/null 2>&1

printf "code: "
read code
rm -f /tmp/torbridge.txt /tmp/torbridge.jpg

post_request=$(curl -X POST -s $url -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" -d "captcha_challenge_field=${key}&captcha_response_field=${code}&submit=submit")

if printf '%s' "${post_request}" | head -10 | grep 'click here' | grep 'bridges?' > /dev/null; then
    echo "Invalid code"
    exit 1
else
    echo "$(printf '%s' "$post_request" | tr '\n' ' ' | sed -e 's/.*<div id="bridgelines"//;s/<\/div>.*//;s/.*"> //;s/<br \/>/\n/g' | sed -e 's/^ *//g')"
fi

exit 0
