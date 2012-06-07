#!/bin/bash

mydir=`dirname $0`
confdir="${mydir}/../conf"

sysrole="$1"

bash "${mydir}/setup_opt.sh"

#set +x

rolescript="${mydir}/role-${sysrole}.sh"

if [ -x "$rolescript" ] ; then
  bash "$rolescript"
fi

true
