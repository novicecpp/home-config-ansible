#! /bin/bash
set -euo pipefail

EMACS_HEAD_FILE=$(realpath ${EMACS_HEAD_FILE:-./emacs_master})

if ! [[ $# == 1 && $1 =~ ^(checkout|-c|master|-m)$ ]]; then
    >&2 echo "Usage: "
    >&2 echo "bash clone.sh checkout|-c # to checkout to commit hash in emacs_master file"
    >&2 echo "bash clone.sh master|-m   # to fetch latest master and replace commit hash in emacs_master file"
    exit 1
fi

if [[ ! -d "emacs" ]]; then
    git clone https://github.com/emacs-mirror/emacs emacs
    #git clone git://git.sv.gnu.org/emacs.git emacs
fi

if [[ $1 == 'checkout' || $1 == '-c' ]]; then
    git checkout $(cat $EMACS_HEAD_FILE)
fi


if [[ $1 == 'master' || $1 == '-m' ]]; then
    FILE_TO_CHECK="${EMACS_HEAD_FILE}"
    if [[ -n $(git status --porcelain -- "${FILE_TO_CHECK}") ]]; then
        git stash
        git checkout stash@{0} -- "${FILE_TO_CHECK}"
        EMACS_COMMIT_HASH="$(cat ${FILE_TO_CHECK})"
        COMMIT_MESSAGE="Auto bump emacs head to ${EMACS_COMMIT_HASH}"
        echo "Commiting emacs_master with emacs commit: ${EMACS_COMMIT_HASH}"
        git add "${FILE_TO_CHECK}"
        git commit -m "${COMMIT_MESSAGE}"
        git stash apply
    fi
    pushd emacs
    git fetch origin
    EMACS_HEAD=$(git rev-parse origin/master)
    git checkout $EMACS_HEAD
    echo -n $EMACS_HEAD > $EMACS_HEAD_FILE
    popd
fi
