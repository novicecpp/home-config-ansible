#! /bin/bash

set -x

if [[ $# != 2 ]]; then
   echo "Usage: "
   echo "bash backup.sh <src> <dst>"
   exit 1
fi

SRCDIR=$1
DSTDIR=$2
printf -v BACKUP_NAME '%(%Y-%m-%d)T_cmsoc_myhome.tar.zstd' -1
BACKUP_PATH=$DSTDIR/$BACKUP_NAME

tar cf - "${SRCDIR}" | pv -brt | zstd -T0 - -o "${BACKUP_PATH}"
sha256sum "${BACKUP_PATH}" > "${BACKUP_PATH}.sha256"
