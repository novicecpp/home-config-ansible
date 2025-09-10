#! /bin/bash
set -euo pipefail
set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

workdir=$SCRIPT_DIR/aur
mkdir -p ${workdir}
rm -rf ${workdir}/*
cp -r PKGBUILD emacs_master $workdir
tar cf ${workdir}/emacs.tar emacs
pushd $workdir
makepkg -f
sudo pacman -U emacs-master*.pkg.tar.zst --noconfirm
popd
