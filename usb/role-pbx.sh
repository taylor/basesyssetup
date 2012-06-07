#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"
installersdir="${mydir}/../installers"
targetdir="/root/pbxsetup/installers"

sysrole="$1"


#NOTE: asterisk moved to ../installers
mkdir -p /root/installers
for installer in pbx rvm asterisk adhearsion polycomtftp fax
do
  if [ -f "${installersdir}/install-${installer}.sh" ] ; then
    cp -v "${installersdir}/install-${installer}.sh" ${targetdir}
  fi
done

echo "Run ${targetdir}/install-pbx.sh after system installation"

#Below no longer run during kickstart
#bash ${mydir}/install-rvm.sh

true
