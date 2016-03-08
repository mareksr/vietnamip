#!/bin/bash


#./2vietnam.sh > l.txt
./3vietnam.pl > black.ip.10

git commit -m "ok"
git push

#load ips
./loadIP.sh

#load nets
./3load.sh




