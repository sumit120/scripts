#!/bin/bash
chmod 644 /tmp/lemmslog
#Checking for package exisitence
if [ ! -d "/usr/local/patchagent" ]; then
echo "Lumension is not running."
echo "Lumension is not not running" | mail -s "LEMMS Status" sumit1203@gmail.com
    exit 1
fi
cd /tmp
#check OS version and architecture
which lsb_release > /dev/null 2>&1
if [ $? -eq 0 ];then
RELEASE=`lsb_release -a | grep Release | awk '{ print $2 }'`
else
#RELEASE=`cat /etc/redhat-release | awk '{ print $7 }'`
RELEASE=`cat /etc/redhat-release | awk '{ print $7,$3 }' |sed "s/^[ \t]*//"`
fi
ARCH=`uname -a | awk '{ print $12 }'`
echo "$RELEASE"
echo "$ARCH"
#install corresponding packages for each OS version and architecture
if [[ $RELEASE = 5* ]] && [[ $ARCH = i*86 ]]; then
echo "$RELEASE release & $ARCH architecture detected, copying file"
cp -f /tmp/lemmslog /etc/logrotate.d/lemmslog
logrotate -vf /etc/logrotate.d/lemmslog
/etc/init.d/syslog restart

elif [[ $RELEASE = 5* ]] && [[ $ARCH = x86_64 ]]; then
echo "$RELEASE release & $ARCH architecture detected, copying file"
cp -f /tmp/lemmslog /etc/logrotate.d/lemmslog
logrotate -vf /etc/logrotate.d/lemmslog > /dev/null 2>&1
/etc/init.d/syslog restart

elif [[ $RELEASE = 6* ]] && [[ $ARCH = i*86 ]]; then
echo "$RELEASE release & $ARCH architecture detected, copying file"
cp -f /tmp/lemmslog /etc/logrotate.d/lemmslog
logrotate -vf /etc/logrotate.d/lemmslog > /dev/null 2>&1
/etc/init.d/rsyslog restart

elif [[ "$RELEASE" = 6* ]] && [[ $ARCH = x86_64 ]]; then
echo "$RELEASE release & $ARCH architecture detected, copying file"
cp -f /tmp/lemmslog /etc/logrotate.d/lemmslog
logrotate -vf /etc/logrotate.d/lemmslog > /dev/null 2>&1
/etc/init.d/rsyslog restart

elif [[ "$RELEASE" = 7* ]] && [[ $ARCH = x86_64 ]]; then
echo "$RELEASE release & $ARCH architecture detected, copying file"
cp -f /tmp/lemmslog /etc/logrotate.d/lemmslog
logrotate -vf /etc/logrotate.d/lemmslog > /dev/null 2>&1
systemctl restart rsyslog

else
        echo "Could not find OS"
        exit 1
fi	
