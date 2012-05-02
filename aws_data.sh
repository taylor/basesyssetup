#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
set -e -x
#REMOTE_SCRIPT="http://codecafe.com/chef/ec2_client_setup.sh"
REMOTE_SCRIPT="https://raw.github.com/gist/2573056/fc8d53841fc1f348694d19a55b7280515ddb2c4b/ec2_chef_client_setup.sh"
wget -nv -O - "$REMOTE_SCRIPT" | bash
set +x
true
