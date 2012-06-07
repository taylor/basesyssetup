#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"

sysrole="$1"

bash ${mydir}/install-rvm.sh
bash ${mydir}/install-asterisk.sh
#bash ${mydir}/install-adhearsion.sh
#bash ${mydir}/install-polycomtftp.sh
#bash ${mydir}/install-fax.sh

true
