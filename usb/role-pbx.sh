#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"
installersdir="${mydir}/../installers"

sysrole="$1"


#NOTE: asterisk moved to ../installers
mkdir -p /root/installers
for installer in pbx rvm asterisk adhearsion polycomtftp fax
do
  if [ -f "${installersdir}/install-${installer}.sh" ] ; then
    cp -v "${installersdir}/install-${installer}.sh" /root/installers
  fi
done

echo "Run /root/installer/install-pbx.sh after system installation"

#bash ${mydir}/install-rvm.sh
#bash ${mydir}/install-asterisk.sh
#bash ${mydir}/install-adhearsion.sh
#bash ${mydir}/install-polycomtftp.sh
#bash ${mydir}/install-fax.sh

true
