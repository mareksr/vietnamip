#!/bin/bash

>/tmp/miki.txt

#ostatnie 30 dni blacklogow

find /usr/local/assp/logs/ -mtime -31 -name *bmail* | while read line
do
	cat $line | grep -E -o "(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?) <\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b>" >> /tmp/miki.txt

done

