#!/bin/bash

#tworzy /tmp/miki.txt zawierajacy ip oraz email
./1vietnam.sh
# tworzy biala liste ip ktore maja zostac usuniete z miki.txt
./white.pl > whitelist
cat whitelist | sort | uniq > whitelist.out


#tworzy liste z geolokacja oraz ilosc wystepowania ip

./2vietnam.sh > l.txt
./3vietnam.pl > black.ip.10

git commit -m "ok"
git commit -a 
git push

#load ips
./loadIP.sh

#load nets
./3load.sh




