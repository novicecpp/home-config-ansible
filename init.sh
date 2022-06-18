#! /bin/bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
   >&2 echo "This script must be run as root using sudo. Rerun it with:"
   >&2 echo "sudo bash init.sh"
   exit 1
fi
USERNAME=$(who | head -n1 | awk '{print $1}')
echo $USERNAME
>2 echo "sudo no password with \"$USERNAME\""
dnf install -y emacs python-pip
cat > /etc/sudoers.d/${USERNAME} \
    <<<"""${USERNAME}        ALL=(ALL)       NOPASSWD: ALL"""
sudo -H -u ${USERNAME} python3 -m pip install --user "ansible<3"
