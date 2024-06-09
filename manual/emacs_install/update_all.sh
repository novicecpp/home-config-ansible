#! /bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR
#bash clone.sh checkout
bash clone.sh master
source /etc/os-release
if [[ $ID = 'arch' ]]; then
    bash make_aur.sh
else
    bash make.sh
fi
emacs --eval '(progn (straight-pull-all) (save-buffers-kill-terminal))'
systemctl restart --user emacs --no-block
popd
