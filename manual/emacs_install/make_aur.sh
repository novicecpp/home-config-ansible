#! /bin/bash
set -euo pipefail
set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

workdir=$SCRIPT_DIR/aur
mkdir -p $workdir
rm -rf $workdir/*
#commit_hash=$(git ls-remote https://github.com/emacs-mirror/emacs HEAD | awk '{print $1}')
#commit_hash=$(cat $SCRIPT_DIR/emacs_master)
#sed -E -e "s/(^pkgver=)([0-9a-f]+\.git)/\1${commit_hash:0:8}\.git/g" -e "s/(emacs#commit=)([0-9a-f]+)/\1${commit_hash}/g" PKGBUILD > $workdir/PKGBUILD
cp -r PKGBUILD emacs emacs_master $workdir
pushd $workdir
makepkg -f
sudo pacman -U emacs-master*.pkg.tar.zst --noconfirm
popd
