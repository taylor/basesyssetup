#!/bin/bash

if [ ! "$UID" = 0 ] ; then
	echo "this should be run as root"
	exit 1
fi

sysrole="$1"

mydir=`dirname $0`
confdir=`${mydir}/..`

bash ${mydir}/user_setup.sh
bash ${mydir}/install_packages.sh "$sysrole"
bash ${mydir}/role_setup.sh "$sysrole"

set +x
true
