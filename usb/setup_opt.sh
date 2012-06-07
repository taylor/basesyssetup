#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"

sysrole="$1"


bash "${mydir}/setup_opt.sh"
# opt setup
set -e -x
cd /opt/downloads
wget ftp://ftp.arlut.utexas.edu/pub/opt_depot/opt_depot-3.02.tar.gz


cat <<EOM> /etc/profile.d/opt.sh
PATH=/opt/bin:$PATH
if [ "$EUID" = "0" ]; then
        PATH=/opt/sbin:$PATH
fi
export PATH
EOM

true
