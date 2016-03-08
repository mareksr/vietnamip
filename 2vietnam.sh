#!/bin/bash

>/tmp/miki.txt

#ostatnie 30 dni blacklogow

find /usr/local/assp/logs/ -mtime -31 -name *bmail* | while read line
do
	cat $line | grep -E -o "(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)" >> /tmp/miki.txt
done

cat /tmp/miki.txt | sort | uniq -c | sort | while read line
do
   checkip=`echo $line | cut -d ' ' -f 2`
   country=`geoiplookup $checkip | grep "Country" | sed  "s/GeoIP Country Edition://" | sed "s/, / \"/g"|  sed "s/$/\"/g" `
   echo "$line$country"
done
