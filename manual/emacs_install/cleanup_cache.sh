#! /bin/bash
set -x
systemctl stop --user emacs
pushd ~/.emacs.d/
rm -rf eln-cache elpa straight tree-sitter
popd
# FIXME: emacs still does not exit after installing package
#emacs --eval '(progn (sit-for 2) (sleep-for 2) (save-buffers-kill-terminal))'
#systemctl start --user emacs
emacs
