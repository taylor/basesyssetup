#!/bin/bash

mydir=`dirname $0`
confdir=`${mydir}/../conf`

set -e -x

RPM_SYS=0
APT_SYS=0

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
  EPELURL="http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-5.noarch.rpm"
  pushd /tmp
  which wget > /dev/null 2>&1
  if [ "$?" = "0" ] ; then
    wget $EPELURL
  else
    curl -o epel-release-6-5.noarch.rpm $EPELURL
  fi

  rpm -Uvh epel-release-6-5.noarch.rpm
  popd
fi

PACKAGE_NAME_LIST=""
PACKAGE_LIST_FILE=${confdir}/${linuxflavor}/packages-common.list
PACKAGE_NAME_LIST=$(cat $PACKAGE_LIST_FILE | grep -v -e "^#" | cut -f1 -d' ')

$pmapp -y install ${PACKAGE_NAME_LIST}

# package names to be installed
PACKAGE_NAME_LIST=""
PACKAGE_LIST_FILE=${confdir}/${linuxflavor}/packages-$sysrole.list

PACKAGE_NAME_LIST=$(cat $PACKAGE_LIST_FILE | grep -v -e "^#" | cut -f1 -d' ')

echo ""
echo "Installing packages:" ${PACKAGE_NAME_LIST}
echo "--------------------------------------------------------------------------------"

$pmapp -y install ${PACKAGE_NAME_LIST}

echo ""
echo "Done"
echo "--------------------------------------------------------------------------------"

set +x
true
