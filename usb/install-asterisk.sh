#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"

sysrole="$1"

set -e -x

mkdir -p /opt/downloads /opt/depot
pushd /opt/downloads
wget http://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-2.6.1+2.6.1.tar.gz
#http://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz

wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-addons-1.6.2.4.tar.gz

wget http://downloads.asterisk.org/pub/telephony/libpri/releases/libpri-1.4.12.tar.gz

wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-1.8.13.0.tar.gz
# http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-1.8-current.tar.gz

tar zxvf dahdi-linux-complete-2.6.1+2.6.1.tar.gz
tar zxvf asterisk-1.8.13.0.tar.gz
tar zxvf asterisk-addons-1.6.2.4.tar.gz
tar zxvf libpri-1.4.12.tar.gz

pushd dahdi-linux-complete-2.6.1+2.6.1
make all
make install
make config
popd


export ASTERISK_INSTALL_DIR=/opt/depot/asterisk-1.8.13.0

pushd asterisk-1.8.13.0
./configure --prefix=$ASTERISK_INSTALL_DIR       --exec-prefix=$ASTERISK_INSTALL_DIR       --localstatedir=$ASTERISK_INSTALL_DIR/var       --sysconfdir=$ASTERISK_INSTALL_DIR/etc

make
make install
popd


set +x
true
