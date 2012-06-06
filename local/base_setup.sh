#!/bin/bash

if [ ! "$UID" = 0 ] ; then
	echo "this should be run as root"
	exit 1
fi

mydir=`dirname $0`

bash ${mydir}/user_setup.sh

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

# START SETUP BASE SYSTEM
$pmapp -y install screen

# TODO: need to install tmux every where

## Screen config

if [ ! -f /root/.screenrc ] ; then
  curl $SCREENRC_URL | tee /etc/skel/.screenrc | tee /root/.screenrc
fi

if [ ! -f /root/.tmux.conf ] ; then
  curl $TMUXCONF_URL | tee /etc/skel/.tmux.conf | tee /root/.tmux.conf
fi

echo export HISTSIZE=9000 | tee -a /etc/skel/.bash_profile | tee -a /root/.bash_profile

# ncurses term for ansi-term in emacs
$pmapp -y install ncurses-term
if ! [ -a /usr/share/terminfo/e/eterm-color ]; then
  ln -s /usr/share/terminfo/e/eterm /usr/share/terminfo/e/eterm-color
fi

## SUDO defaults
sed -ire '/NOPASSWD/ s/^# //' /etc/sudoers # %sudo doesn't need a password now!

# add our public keys to all new users, and to the default user
mkdir -p /etc/skel/.ssh
#curl http://codecafe.com/chris/ssh.pub | tee -a /etc/skel/.ssh/authorized_keys
#curl http://codecafe.com/taylor/ssh.pub | tee -a /etc/skel/.ssh/authorized_keys
# curl http://codecafe.com/wayne/ssh.pub | tee -a /etc/skel/.ssh/authorized_keys
#curl http://codecafe.com/wayne/ssh-backup.pub | tee -a /etc/skel/.ssh/authorized_keys

cat <<"EOS"| tee -a /tmp/setup_user_account
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
cat /etc/skel/.ssh/authorized_keys >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
cp /etc/skel/.screenrc ~/
echo export HISTSIZE=9000 | tee -a ~/.bash_profile
EOS
chmod +x /tmp/setup_user_account

if [ -d /home/ubuntu ] ; then
  U=ubuntu
elif [ -d /home/ec2-user ] ; then
  U=ec2-user
else
  U=""
fi

if [ -n "$U" ] ; then
  su - $U -c "sh /tmp/setup_user_account"
fi
# END SETUP BASE SYSTEM

set +x
true
