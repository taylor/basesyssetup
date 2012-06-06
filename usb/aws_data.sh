#!/bin/bash

set -e -x
echo "Setting up base system"
REMOTE_SCRIPT="https://raw.github.com/gist/2573056/74237aada624251de7ddfe5e8b98a6e39f736e43/base_setup.sh"
wget -nv -O - "$REMOTE_SCRIPT" | bash
set +x
true
