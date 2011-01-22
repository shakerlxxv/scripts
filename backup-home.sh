#!/bin/bash
# backup personal data customized in most cases to be most efficient
# for specific applications.
#    1. backup evolution to an external disk.
ADMIN=shakerlxxv@gmail.com
BACKUP_FILE=/mnt/Documents/4DogsTechnologies/BriansNotes/evolution-backup.tar.gz

function check_mount () {
    _MNT_SRC=$1
    _MNT_CHK=`mount | grep "${_MNT_SRC}"`
    return `test -n "${_MNT_CHK}"`
}

#
# 1. backup evolution
#
#{ check_mount /mnt/Documents &&
#   /usr/libexec/evolution/2.30/evolution-backup --backup ${BACKUP_FILE}; } ||
#  echo "Evolution backup failure" | mailx -s "BACKUP_FAILURE Evolution" ${ADMIN}

#
# 2. backup Hamster ( time tracking )
#
{ check_mount /mnt/Documents &&
  cp /home/bshaver/.local/share/hamster-applet/hamster.db /mnt/Documents/4DogsTechnologies/BriansNotes/; } ||
    echo "Time Tracking Backup Failure" | mailx -s "BACKUP FAILURE Time Tracking" ${ADMIN}

#
# 3. backup gnote ( journal and ideas )
#
{ check_mount /mnt/Documents &&
    cd /home/bshaver/.local/share && tar czf /mnt/Documents/4DogsTechnologies/BriansNotes/gnote-backup.tar.gz gnote; } ||
      echo "Gnote Backup Failure" | mailx -s "BACKUP FAILURE Gnote" ${ADMIN}
