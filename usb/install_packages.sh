#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"

sysrole="$1"

RPM_SYS=0
APT_SYS=0

set -x

which rpm > /dev/null 2>&1
#which apt-get > /dev/null 2>&1

if [ "$?" = "0" ] ; then
  RPM_SYS=1
  pmapp=yum
  linuxflavor=centos
else
  APT_SYS=1
  pmapp=apt-get
  linuxflavor=debian
fi

if [ "$RPM_SYS" ] ; then
  which wget > /dev/null 2>&1
  if [ ! "$?" = 0 ] ; then
    $pmapp -y install wget
  fi
  EPELRPM="epel-release-6-7.noarch.rpm"
  EPELURL="http://download.fedoraproject.org/pub/epel/6/i386/${EPELRPM}"
  pushd /tmp
  wget $EPELURL
  rpm -Uvh "$EPELRPM"
  popd
fi

function installpackages() {
# package names to be installed
  PACKAGE_NAME_LIST=""
  PACKAGE_LIST_FILE="$*"
  PACKAGE_NAME_LIST=$(cat $PACKAGE_LIST_FILE | grep -v -e "^#" | cut -f1 -d' ')

  echo ""
  echo "Installing packages:" ${PACKAGE_NAME_LIST}
  echo "--------------------------------------------------------------------------------"

  $pmapp -y install ${PACKAGE_NAME_LIST}

  echo ""
  echo "Done"
  echo "--------------------------------------------------------------------------------"
}

#PACKAGE_LIST_FILE=${confdir}/${linuxflavor}/packages-$sysrole.list
for pf in packages-common.list packages-$sysrole.list
do
  echo "Checking packages in $pf"
  conf="${confdir}/$linuxflavor/$pf"
  if [ -s "${conf}" ] ; then 
    installpackages "$conf"
  else
    echo "$pf is empty"
  fi
done

set +x
true
