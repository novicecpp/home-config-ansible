#! /bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR
bash clone.sh master
bash make.sh
emacs --eval '(progn (straight-pull-all) (save-buffers-kill-terminal))'
systemctl restart --user emacs --no-block
popd
