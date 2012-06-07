#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"
installersdir="${mydir}"

sysrole="$1"


bash ${installersdir}/install-rvm.sh
bash ${installersdir}/install-asterisk.sh
#bash ${installersdir}/install-adhearsion.sh
#bash ${installersdir}/install-polycomtftp.sh
#bash ${installersdir}/install-fax.sh

true
