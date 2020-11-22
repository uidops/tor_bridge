# get tor bridges with bash
![Language](http://img.shields.io/:language-BASH-red.svg?style=flat-square) ![License](http://img.shields.io/:license-GPL-blue.svg?style=flat-square)

tested on (arch linux + i3wm)

Dependencies:
```
curl
feh
pup
```

Install and usage:
``` bash
$ sudo pacman -S curl feh git
$ yay -S pup-bin
$ git clone https://github.com/siruidops/tor_bridge.git
$ cd tor_bridge/
$ chmod +x bridge.sh

$ ./bridge.sh obfs4
$ ./bridge.sh none
```

Screenshot:
<img src="https://github.com/siruidops/tor_bridge/raw/main/screenshot.png"></img>
