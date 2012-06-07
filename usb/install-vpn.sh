#!/bin/bash

if [ ! "$UID" = 0 ] ; then
	echo "this should be run as root"
	exit 1
fi

sysrole="$1"

mydir=`dirname $0`
confdir="${mydir}/../conf"

#vpndir=...
#vpncert=...

#if [ -f vpncert... 

#set -x
#set +x

true
