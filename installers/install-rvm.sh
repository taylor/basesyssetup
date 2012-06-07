#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"

sysrole="$1"

#sudo curl -L get.rvm.io | sudo bash -s stable
curl -L get.rvm.io | sudo bash -s stable
