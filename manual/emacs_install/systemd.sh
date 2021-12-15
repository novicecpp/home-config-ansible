#!/bin/bash
set -euo pipefail
# copy emacs.service to systemd
USER_SYSTEMD_PATH=~/.config/systemd/user/
mkdir -p ${USER_SYSTEMD_PATH}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cp ${SCRIPT_DIR}/emacs.service ${USER_SYSTEMD_PATH}/emacs.service
systemctl daemon-reload --user
