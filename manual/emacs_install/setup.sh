#!/bin/bash
set -euo pipefail

# remove system packages
# if arch/pacman
which pacman
retval=$?
if [[ $retval == 0 ]]; then
    sudo pacman -R emacs-nox --noconfirm
    sudo pacman -R emacs --noconfirm
fi

# copy emacs.service to systemd
USER_SYSTEMD_PATH=~/.config/systemd/user/
mkdir -p ${USER_SYSTEMD_PATH}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cp ${SCRIPT_DIR}/emacs.service ${USER_SYSTEMD_PATH}/emacs.service
systemctl daemon-reload --user
systemctl enable --user emacs
