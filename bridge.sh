echo "Welcome to torproject bridge {author: uidops}"
echo

if [ $1 == 'obfs4' ]
then
	url="https://bridges.torproject.org/bridges?transport=obfs4"
else
	url="https://bridges.torproject.org/bridges?transport=0"
fi
get_request=$(curl -X GET -s $url)
field=$(echo $get_request | tr " " "\n" | grep 'value=\"' | sed -e 's/value="/\ /;s/" /\ /')
word='</input>'
word2='"'
word3=">"
word4="submit"
word5=" "
a=$(echo "${field//$word}")
b=$(echo "${a//$word2}")
b=$(echo "${b//$word3}")
b=$(echo "${b//$word4}")
key=$(echo "${b//$word5}")
field=$(echo $get_request | tr " " "\n" | grep 'src="data:image/jpeg;base64')
a=$(echo "${field//$word2}")
word="src=data"
word1=":"
word2="image/"
word4="jpeg;"
word6="base64,"
a=$(echo "${a//$word}")
a=$(echo "${a//$word1}")
a=$(echo "${a//$word2}")
a=$(echo "${a//$word4}")
img=$(echo "${a//$word6}")
echo $img > /tmp/torbridge.txt
base64 -d /tmp/torbridge.txt > /tmp/torbridge.jpg
viu /tmp/torbridge.jpg
echo
printf "code: "
read code
post_request=$(curl -X POST -s $url -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" -d "captcha_challenge_field=${key}&captcha_response_field=${code}&submit=submit")
echo
echo $post_request | pup 'div.bridge-lines text{}'
