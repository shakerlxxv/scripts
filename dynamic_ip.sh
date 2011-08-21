#!/bin/bash
#==============================================================================
# Simple script to monitor for IP address changes
#==============================================================================
LAST_IP_FILE=~/.dynip_last
ADMIN=shakerlxxv@gmail.com

# read last IP
LAST_ADDR=`cat ${LAST_IP_FILE} 2>/dev/null`
#CUR_ADDR=`/sbin/ip addr show eth0 | grep -w inet | /usr/bin/awk '{print $2}'`
CUR_ADDR=`/usr/bin/wget -qO - http://192.168.1.1/htmlV/index.asp | grep "IPPassThruState_IPAddress =" | awk -F\" '{print $2}'`

if [ "$LAST_ADDR" != "$CUR_ADDR" ]; then
  if [ "$1" = "set" ]; then
    echo $CUR_ADDR > $LAST_IP_FILE
  else
    printf "New IP: $CUR_ADDR\n" | mailx -s "DYNAMIC IP CHANGE" $ADMIN
  fi
fi

echo "`date` ${CUR_ADDR}" >> ~/.dynip_log

