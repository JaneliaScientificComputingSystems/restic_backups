#!/usr/bin/env bash

# What to backup, and what to not
BACKUP_EXCLUDES="--exclude-file backup_exclude"
TIMESTAMP=`date "+%Y%m%d-%H%M%S"`
BACKUP_TAG1=`hostname -s`
BACKUP_TAG2=`hostname -s`-${TIMESTAMP}

# How many backups to keep.
KEEP_LAST=4
RETENTION_HOURS=4
RETENTION_DAYS=30
RETENTION_WEEKS=12
RETENTION_MONTHS=12
RETENTION_YEARS=3

# Set all environment variables
source /root/.restic_env 
source backup_include

./restic backup \
    --verbose \
    --one-file-system \
    --tag $BACKUP_TAG1 \
    --tag $BACKUP_TAG2 \
    $BACKUP_EXCLUDES \
    $BACKUP_PATHS

# Dereference old backups.

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

