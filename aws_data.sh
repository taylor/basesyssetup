#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
set -e -x
#REMOTE_SCRIPT="http://codecafe.com/chef/ec2_client_setup.sh"
REMOTE_SCRIPT="http://git.io/ec2chefclient.1b"
wget -nv -O - "$REMOTE_SCRIPT" | bash
set +x
true
