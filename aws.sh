#!/bin/bash

set -e -x
#REMOTE_SCRIPT="http://codecafe.com/chef/ec2_client_setup.sh"
REMOTE_SCRIPT="http://git.io/ec2chefclient.1b"
wget -nv -O - "$REMOTE_SCRIPT" | bash
set +x
true
