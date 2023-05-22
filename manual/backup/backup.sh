#! /bin/bash

if [[ $# != 2 ]]; then
   echo "Usage: "
   echo "bash backup.sh <src> <dst>"
   exit 1
fi

SRCDIR=$1
DSTDIR=$2
MACHINE_NAME=${MACHINE_NAME:-x1g2}
DIR_NAME=${DIR_NAME:-myhome}
printf -v BACKUP_PATH '%s/%(%Y-%m-%d)T_%s_%s.tar.zstd' "$DSTDIR" -1 "$MACHINE_NAME" "$DIR_NAME"

echo "Backup from $SRCDIR to $BACKUP_PATH"

tar --ignore-failed-read -cf - "${SRCDIR}" | pv -brt | zstd -T0 -o "${BACKUP_PATH}" -

echo "Running checksum..."
sha256sum "${BACKUP_PATH}" > "${BACKUP_PATH}.sha256"
