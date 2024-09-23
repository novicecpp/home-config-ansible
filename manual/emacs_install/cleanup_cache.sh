#! /bin/bash
set -euo pipefail
set -x

systemctl stop --user emacs
pushd ~/.emacs.d/
rm -rf rm -rf eln-cache elpa straight elpaca
popd
emacs --eval '(progn (elpaca-pull-all) (save-buffers-kill-terminal))'
systemctl start --user emacs
