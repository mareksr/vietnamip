#!/bin/bash


DIR='/opt/megaspam/vietnamip'

#tworzy /tmp/miki.txt zawierajacy ip oraz email
echo "1vietnam.sh"
$DIR/1vietnam.sh
# tworzy biala liste ip ktore maja zostac usuniete z miki.txt
#echo "whitelist"
#$DIR/white.pl 
#cat $DIR/whitelist | sort | uniq > $DIR/whitelist.out


#tworzy liste z geolokacja oraz ilosc wystepowania ip
echo "2vietnam.sh"
$DIR/2vietnam.sh > $DIR/l.txt
echo "3vietnam.sh"
$DIR/3vietnam.pl > $DIR/black.ip.10
sed -i '/City/d' $DIR/black.ip.10
cp $DIR/black.ip.10 /shared/

#load ips
#./loadIP.sh

#load nets
#./3load.sh




