#!/bin/bash
# list of commands used to backup the network storage device
#rsync -avz --modify-window=1 /mnt/Documents /media/BIGDISK4
#rsync -avz --modify-window=1 --exclude 'Video' /mnt/Photos /media/ION\ DRIVE\ A/
#rsync -avz --modify-window=1 --exclude='Music/[J-Z]*' /mnt/Music /media/ION\ DRIVE\ C
#rsync -avz --modify-window=1 --include='Music/[J-Z]*' --exclude='Music/*' /mnt/Music /media/ION\ DRIVE\ B

RS_OPT="/usr/bin/rsync -avz --modify-window=1"
ADMIN=shakerlxxv@gmail.com

function check_mount () {
    _MNT_SRC=$1
    _MNT_CHK=`mount | grep "${_MNT_SRC}"`
    return `test -n "${_MNT_CHK}"`
}

{ check_mount /mnt/Documents &&
  check_mount /media/BIGDISK4 &&
  ${RS_OPT} --exclude='*:*' /mnt/Documents /media/BIGDISK4; } ||
echo "Documents backup failure" | mailx -s "BACKUP FAILURE" ${ADMIN}

{ check_mount /mnt/Photos &&
  check_mount "/media/ION DRIVE A" &&
  ${RS_OPT} --exclude='Video' /mnt/Photos /media/ION\ DRIVE\ A; } ||
echo "Photos backup failure" | mailx -s "BACKUP_FAILURE" ${ADMIN}

{ check_mount /mnt/Music &&
  check_mount "/media/ION DRIVE C" &&
  ${RS_OPT} --exclude='Music/[J-Z]*' /mnt/Music /media/ION\ DRIVE\ C; } ||
echo "Music #1 backup failure" | mailx -s "BACKUP FAILURE" ${ADMIN}

{ check_mount /mnt/Music &&
  check_mount "/media/ION DRIVE B" &&
  ${RS_OPT} --include='Music/[J-Z]*' --exclude='Music/*' /mnt/Music /media/ION\ DRIVE\ B; } ||
echo "Music #2 backup failure" | mailx -s "BACKUP FAILURE" ${ADMIN}
