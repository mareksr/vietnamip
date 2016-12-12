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

[root@HMspamFilterBackup vietnamip]# cat 2vietnam.sh
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

