#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
else
#	/usr/bin/curl 127.0.0.1:22
	/home/sysadmin/curl $*
fi
