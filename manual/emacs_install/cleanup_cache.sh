#! /bin/bash
set -euo pipefail
set -x

systemctl stop --user emacs
pushd ~/.emacs.d/
rm -rf rm -rf eln-cache elpa straight elpaca
popd
echo "start emacs to reinstall packages and start emacs daemon again: "
echo "systemctl start --user emacs"
# it does not work
# emacs --eval '(progn (elpaca-pull-all) (save-buffers-kill-terminal))'
