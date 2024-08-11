#!/bin/bash
set -euo pipefail

# remove system packages
# if arch/pacman
which pacman
retval=$?
if [[ $retval == 0 ]]; then
    echo "try to remove emacs from pacman"
    sudo pacman -R emacs-nox --noconfirm || true
    sudo pacman -R emacs --noconfirm || true
fi

# copy emacs.service to systemd
USER_SYSTEMD_PATH=~/.config/systemd/user/
mkdir -p ${USER_SYSTEMD_PATH}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cp ${SCRIPT_DIR}/emacs.service ${USER_SYSTEMD_PATH}/emacs.service
systemctl daemon-reload --user
systemctl enable --user emacs
