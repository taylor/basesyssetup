#!/bin/bash

if [ ! "$UID" = 0 ] ; then
	echo "this should be run as root"
	exit 1
fi

mydir=`dirname $0`
confdir=`${mydir}/../conf`
keydir=`${mydir}/../keys`

SCREENRC_URL="${confdir}/screenrc"
TMUXCONF_URL="${confdir}/tmuxrc"

set -e -x

mkdir -p /root/.ssh /etc/skel/.ssh
touch /root/.ssh/authorized_keys /etc/skel/.ssh/authorized_keys
chmod 700 /root/.ssh /etc/skel/.ssh
chmod 600 /root/.ssh/authorized_keys /etc/skel/.ssh/authorized_keys

for user in backuppc chris jim taylor wwalker ; do
  if ! grep $user /root/.ssh/authorized_keys ; then
    cat ${keydir}/${user}-ssh.pub | tee -a /etc/skel/.ssh/authorized_keys | tee -a /root/.ssh/authorized_keys
  fi
done

sed -i.orig 's/^PermitRootLogin/#PermitRootLogin/' /etc/ssh/sshd_config
echo "PermitRootLogin yes" | tee -a /etc/ssh/sshd_config
service ssh restart
service sshd restart

echo export HISTSIZE=9000 | tee -a /etc/skel/.bash_profile | tee -a /root/.bash_profile
echo HISTCONTROL=ignoreboth |tee -a /etc/skel/.bashrc |tee -a /root/.bashrc
echo shopt -s histappend |tee -a /etc/skel/.bashrc |tee -a /root/.bashrc

## SUDO defaults
sed -ire '/NOPASSWD/ s/^# //' /etc/sudoers # %sudo doesn't need a password now!

## TMUX/Screen config

if [ ! -f /root/.screenrc ] ; then
  cat $SCREENRC_URL | tee /etc/skel/.screenrc | tee /root/.screenrc
fi

if [ ! -f /root/.tmux.conf ] ; then
  cat $TMUXCONF_URL | tee /etc/skel/.tmux.conf | tee /root/.tmux.conf
fi

set +x
true
