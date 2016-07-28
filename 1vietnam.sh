#!/bin/bash

>/tmp/miki.txt
>/tmp/.miki.txt

#ostatnie 30 dni blacklogow

find /usr/local/assp/logs/ -mtime -31 -name *bmail*gz | while read line
do
	zcat $line | grep -v passing | grep -E -o "(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[1]?[0-9][0-9]?) <\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b>" >> /tmp/.miki.txt

done


#get if #ip is >10

echo "creating miki.txt"
cat /tmp/.miki.txt  | sort -k 1,1  |  sort -n | awk '{print $3" "$2" "$1}'  | uniq -c -f 1 | awk -v limit=10 '$1 > limit{print $3}' |  grep -wFf- /tmp/.miki.txt > /tmp/miki.txt


#wywal IP dla ktorych domeny znajduja sie na WL
cat /usr/local/assp/files/whitedomains.txt  | cut -d '@' -f 2 |  grep -wFf- /tmp/miki.txt > /tmp/miki2.txt

#wywal bardzo znane domeny. dostajemy ip ktore musza byc usuniete z blackisty
cat /opt/megaspam/vietnamip/domains.txt | grep -vFf- /tmp/miki2.txt | cut -d ' ' -f1 | sort | uniq > /opt/megaspam/vietnamip/whitelist.out

cat /opt/megaspam/vietnamip/whitelist.out | fgrep -vf- /tmp/miki.txt | cut -d ' ' -f 1 | sort | uniq > /opt/megaspam/vietnamip/black.ip.10


cd /opt/megaspam/vietnamip/
git commit -a -m 'autocommit on change'

git push

/opt/megaspam/vietnamip/loadIP.sh

