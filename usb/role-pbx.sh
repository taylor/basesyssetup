#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"
installers="${mydir}/../installers"

sysrole="$1"


#NOTE: asterisk moved to ../installers
mkdir -p /root/installers
for installer in rvm asterisk adhearsion polycomtftp fax
do
  cp "${installers}/install-${installer}.sh" /root/installers
done

#bash ${mydir}/install-rvm.sh
#bash ${mydir}/install-asterisk.sh
#bash ${mydir}/install-adhearsion.sh
#bash ${mydir}/install-polycomtftp.sh
#bash ${mydir}/install-fax.sh

true
