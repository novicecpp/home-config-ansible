#! /bin/bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
   >2 echo "This script must be run as root"
   exit 1
fi
USERNAME=$(who | awk '{print $1}')
>2 echo "sudo no password with \"$USERNAME\""
dnf install -y emacs
cat > /etc/sudoers.d/${USERNAME} \
    <<<"""${USERNAME}        ALL=(ALL)       NOPASSWD: ALL"""
sudo -H -u ${USERNAME} python3 -m pip install "ansible<3"
