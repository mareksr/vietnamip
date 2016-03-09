#!/bin/bash

ipset flush blacklist

curl https://raw.githubusercontent.com/mareksr/vietnamip/master/black.ip.10  | while read ip
do
        ip2=`echo $ip |sed "s/ .*//g"`
        ipset add blacklist $ip2
done

