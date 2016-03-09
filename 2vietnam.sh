#!/bin/bash


cat /tmp/miki.txt  | cut -d ' ' -f 1 > /tmp/miki2.txt
combine /tmp/miki2.txt not whitelist.out  > /tmp/miki3.txt

cat /tmp/miki3.txt | sort | uniq -c | sort | while read line
do
   checkip=`echo $line | cut -d ' ' -f 2`
   country=`geoiplookup $checkip | grep "Country" | sed  "s/GeoIP Country Edition://" | sed "s/, / \"/g"|  sed "s/$/\"/g" `
   echo "$line$country"
done


#Mar-09-16 00:00:33 m1-78030-02340 [Worker_1] [URIBL] 74.221.210.19 <DiabetesDefeatedSystem@uscrez.win> to: informatyk@e-fresh.pl [spam found] (URIBLcache: fail, uscrez.win listed in multi.surbl.org) [Why This Secret Ingredient Reverses Type 2 Diabetes] -> /usr/local/assp5/spam/2340.eml;

