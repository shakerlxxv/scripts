#!/bin/bash
# backup personal data customized in most cases to be most efficient
# for specific applications.
#    1. backup evolution to an external disk.
ADMIN=shakerlxxv@gmail.com
BACKUP_PARTITION=/mnt/backup1
BACKUP_BASE=${BACKUP_PARTITION}/Backup
RS_OPT="/usr/bin/rsync -avz --modify-window=1"

function check_mount () {
    _MNT_SRC=$1
    _MNT_CHK=`mount | grep "${_MNT_SRC}"`
    return `test -n "${_MNT_CHK}"`
}

mkdir -p ${BACKUP_BASE}

#
# backup bshaver home
#
{ check_mount ${BACKUP_PARTITION} &&
  ${RS_OPT} --exclude 'Downloads' --exclude '.cache' --exclude '.ccache' --exclude '.SpiderOak' /home/bshaver ${BACKUP_BASE}; } ||
echo "Home backup failure" | mailx -s "BACKUP_FAILURE" ${ADMIN}
