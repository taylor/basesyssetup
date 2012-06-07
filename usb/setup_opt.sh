#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"

sysrole="$1"

# opt setup
set -e -x

mkdir -p /opt/downloads /opt/depot /opt/src

cd /opt/downloads
wget ftp://ftp.arlut.utexas.edu/pub/opt_depot/opt_depot-3.02.tar.gz

cat <<"EOM"> /etc/profile.d/opt.sh
PATH=/opt/bin:$PATH
if [ "$EUID" = "0" ]; then
        PATH=/opt/sbin:$PATH
fi
export PATH
EOM

set -e +x

true
