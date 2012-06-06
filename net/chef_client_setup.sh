#!/bin/bash

if [ ! "$UID" = 0 ] ; then
	echo "this should be run as root"
	exit 1
fi

set -e -x
wget -nv -O - http://www.opscode.com/chef/install.sh | bash
set +x
true
