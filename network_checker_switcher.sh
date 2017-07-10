#!/bin/bash

CAN_PING_SKY_ROUTER=0
CAN_PING_INTERNET_ON_ETH=0
CAN_PING_INTERNET_ON_WIFI=0

#/sbin/route add 209.244.0.3 gw 192.168.3.1

while :
do
	if ping -I enp2s0f2 -c 1 -W 1 192.168.0.1 &> /dev/null; then
		if [ "$CAN_PING_SKY_ROUTER" == 0 ]; then
			/usr/bin/notify-send "Ethernet can now ping the Sky router"
			echo `date`:enp2s0f2 can ping the Sky router
		fi
		CAN_PING_SKY_ROUTER=1
		if ping -I enp2s0f2 -c 1 -W 1 209.244.0.3 &> /dev/null; then
			if [ "$CAN_PING_INTERNET_ON_ETH" == 0 ]; then
				/usr/bin/notify-send "Ethernet can now ping the internet"
				echo `date`:enp2s0f2 has internet conectivity
			fi
			CAN_PING_INTERNET_ON_ETH=1
		        #/sbin/route del default gw 192.168.1.1
	        	#/sbin/route add default gw 192.168.3.1
		else
	        	if [ "$CAN_PING_INTERNET_ON_ETH" == 1 ]; then
				/usr/bin/notify-send "Ethernet can not ping the internet"
				echo `date`:enp2s0f2 has not got internet conectivity
			fi
			CAN_PING_INTERNET_ON_ETH=0
	        	#echo `date` 4G Down >> /var/log/4glog.txt
	        	#/sbin/route del default gw 192.168.3.1
	        	#/sbin/route add default gw 192.168.1.1
		fi
	else
		if [ "$CAN_PING_SKY_ROUTER" == 1 ]; then
			/usr/bin/notify-send "Ethernet can not ping the Sky router"
			echo `date`:enp2s0f2 can not ping the Sky router
		fi
		CAN_PING_SKY_ROUTER=0
	fi
	
	if ping -I wlp3s0 -c 1 -W 1 209.244.0.3 &> /dev/null; then
		if [ "$CAN_PING_INTERNET_ON_WIFI" == 0 ]; then
			/usr/bin/notify-send "WiFi now has internet conectivity!"
			echo `date`:wlp3s0 has internet conectivity
		fi
		CAN_PING_INTERNET_ON_WIFI=1
	        #/sbin/route del default gw 192.168.1.1
	        #/sbin/route add default gw 192.168.3.1
	else
		if [ "$CAN_PING_INTERNET_ON_WIFI" == 1 ]; then
			/usr/bin/notify-send "WiFi now has lost internet conectivity!"
			echo `date`:wlp3s0 has not got internet conectivity
		fi
		CAN_PING_INTERNET_ON_WIFI=0
	        #echo `date` 4G Down >> /var/log/4glog.txt
	        #/sbin/route del default gw 192.168.3.1
	        #/sbin/route add default gw 192.168.1.1
	fi
done

#/sbin/route del 209.244.0.3
