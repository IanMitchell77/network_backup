#!/bin/bash

#/sbin/route add 209.244.0.3 gw 192.168.3.1

if ping -I enp2s0f2 -c 1 -W 1 209.244.0.3 &> /dev/null; then
        echo enp2s0f2 has internet conectivity
        #/sbin/route del default gw 192.168.1.1
        #/sbin/route add default gw 192.168.3.1
else
        echo enp2s0f2 has not got internet conectivity
        #echo `date` 4G Down >> /var/log/4glog.txt
        #/sbin/route del default gw 192.168.3.1
        #/sbin/route add default gw 192.168.1.1
fi

if ping -I wlp3s0 -c 1 -W 1 209.244.0.3 &> /dev/null; then
        echo wlp3s0 has internet conectivity
        #/sbin/route del default gw 192.168.1.1
        #/sbin/route add default gw 192.168.3.1
else
        echo wlp3s0 has not got internet conectivity
        #echo `date` 4G Down >> /var/log/4glog.txt
        #/sbin/route del default gw 192.168.3.1
        #/sbin/route add default gw 192.168.1.1
fi

#/sbin/route del 209.244.0.3
