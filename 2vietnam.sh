#!/bin/bash


cat /tmp/miki.txt  | cut -d ' ' -f 1 > /tmp/miki2.txt
combine /tmp/miki2.txt not /opt/megaspam/vietnamip/whitelist.out  > /tmp/miki3.txt

cat /tmp/miki3.txt | sort | uniq -c | sort | while read line
do
   checkip=`echo $line | cut -d ' ' -f 2`
   country=`geoiplookup $checkip | grep "Country" | sed  "s/GeoIP Country Edition://" | sed "s/, / \"/g"|  sed "s/$/\"/g" `
   echo "$line$country"
done



