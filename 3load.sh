#!/bin/bash


COUNTRIES="`wget -qO- https://raw.githubusercontent.com/mareksr/vietnamip/master/geoblock.list`"

ipset flush  geoblock
echo $COUNTRIES

for B in $COUNTRIES
do

C=`echo "$B" | tr "[:upper:]" "[:lower:]"`
echo "Loading $C"
for IP in $(wget --quiet  -O - http://www.ipdeny.com/ipblocks/data/countries/$C.zone)
do
	# really big hammer - block countryX, period
	 ipset add geoblock $IP
done

done
echo "Loaded nets:" 
ipset list geoblock | wc -l 
