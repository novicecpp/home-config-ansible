#! /bin/bash

set -euo pipefail
set -x
if [[ ${SUDO_COMMAND+x} != x ]]; then
   >&2 echo "This script must be run using sudo with normal user (assumed the user already in sudoers group)"
   >&2 echo "Rerun it with:"
   >&2 echo "sudo bash $0"
   exit 1
fi
USERNAME=$SUDO_USER
echo $USERNAME
echo "sudo no password with \"$USERNAME\""
cat > /etc/sudoers.d/${USERNAME} \
    <<<"""${USERNAME}        ALL=(ALL)       NOPASSWD: ALL"""
