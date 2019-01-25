#!/bin/bash

#
TOPDIR="/root/restic_backups"

#  
BACKUP_EXCLUDES="--exclude-file backup_exclude"
TIMESTAMP=`date "+%Y%m%d-%H%M%S"`
BACKUP_TAG1=`hostname -s`
BACKUP_TAG2=`hostname -s`-${TIMESTAMP}

# 
KEEP_LAST=4
RETENTION_HOURS=4
RETENTION_DAYS=30
RETENTION_WEEKS=12
RETENTION_MONTHS=12
RETENTION_YEARS=3

#
cd $TOPDIR 
source /root/.restic_env 
source backup_include

git pull

./restic backup \
    --verbose \
    --one-file-system \
    --tag $BACKUP_TAG1 \
    --tag $BACKUP_TAG2 \
    $BACKUP_EXCLUDES \
    $BACKUP_PATHS

# 

./restic forget \
    --verbose \
    --tag $BACKUP_TAG1 \
    --keep-last $KEEP_LAST \
    --keep-hourly $RETENTION_HOURS \
    --keep-daily $RETENTION_DAYS \
    --keep-weekly $RETENTION_WEEKS \
    --keep-monthly $RETENTION_MONTHS \
    --keep-yearly $RETENTION_YEARS \
    --prune