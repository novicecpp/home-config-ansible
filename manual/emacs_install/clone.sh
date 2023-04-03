#! /bin/bash
EMACS_HEAD_FILE=${EMACS_HEAD_FILE:-./emacs_master}

if [[ ! -d "emacs" ]]; then
    git clone git://git.sv.gnu.org/emacs.git emacs
fi

if ! [[ $# == 1 && $1 =~ ^(checkout|-c|master|-m)$ ]]; then
    >&2 echo "Usage: "
    >&2 echo "bash clone.sh checkout|-c # to checkout to commit hash in emacs_master file"
    >&2 echo "bash clone.sh master|-m   # to fetch latest master and replace commit hash in emacs_master file"
    exit 1
fi

pushd emacs
git fetch origin master

if [[ $1 == 'checkout' || $1 == '-c' ]]; then
    git checkout $(cat ../emacs_master)

fi

if [[ $1 == 'master' || $1 == '-m' ]]; then
    git fetch origin
    EMACS_HEAD=$(git rev-parse origin/master)
    git checkout $EMACS_HEAD
    popd > /dev/null
    echo $EMACS_HEAD > ../$EMACS_HEAD_FILE
fi
popd
