#!/bin/bash

>/tmp/miki.txt

#ostatnie 30 dni blacklogow

find /usr/local/assp/logs/ -mtime -31 -name *bmail*gz | while read line
do
	echo $line
	zcat $line | grep -E -o "(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?) <\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b>" >> /tmp/.miki.txt

done


#get if #ip is >10

cat /tmp/.miki.txt  | cut -d ' ' -f 1 | sort | uniq -c | sort -n | awk -v limit=10 '$1 > limit{print $2}' > /tmp/miki.txt





