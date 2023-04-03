#! /bin/bash
set -x
systemctl stop --user emacs
rm -rf ~/.emacs.d/eln-cache/ ~/.emacs.d/elpa
# FIXME: emacs still does not exit after installing package
#emacs --eval '(progn (sit-for 2) (sleep-for 2) (save-buffers-kill-terminal))'
#systemctl start --user emacs
