#!/bin/bash

mydir=`dirname $0`
confdir=`${mydir}/..`

set -e -x

RPM_SYS=0
APT_SYS=0

which rpm > /dev/null 2>&1
#which apt-get > /dev/null 2>&1

if [ "$?" = "0" ] ; then
  RPM_SYS=1
  pmapp=yum
else
  APT_SYS=1
  pmapp=apt-get
fi

if [ "$RPM_SYS" ] ; then
  pushd /tmp
  wget http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-5.noarch.rpm
  rpm -Uvh epel-release-6-5.noarch.rpm
  popd
fi

#FIXME: package file list for dist

PACKAGE_NAME_LIST=""
PACKAGE_LIST_FILE=${confdir}/packages-common.list
PACKAGE_NAME_LIST=$(cat $PACKAGE_LIST_FILE | grep -v -e "^#" | cut -f1 -d' ')

$pmapp -y install ${PACKAGE_NAME_LIST}

# package names to be installed
PACKAGE_NAME_LIST=""
PACKAGE_LIST_FILE=${confdir}/packages-$sysrole.list

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
