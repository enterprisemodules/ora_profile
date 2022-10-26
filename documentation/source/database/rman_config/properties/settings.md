The settings you wish to apply on your database(s).
For example:

```yaml
ora_profile::database::rman_config::settings:
  DB122:
    archivelog_backup_copies:
      DISK: '1'
    backup_optimization: 'ON'
    channel:
      DISK:
        '1': "FORMAT '/u01/backup/DB122_1_%U' MAXPIECESIZE 1024M RATE 1G"
        '2': "FORMAT '/u01/backup/DB122_2_%U' MAXPIECESIZE 1024M RATE 1G"
    controlfile_autobackup: 'ON'
    controlfile_autobackup_format:
      DISK: '/u01/backup/DB122_%F'
    device:
      DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
  DB180:
    archivelog_backup_copies:
      DISK: '1'
    backup_optimization: 'ON'
    controlfile_autobackup: 'ON'
    controlfile_autobackup_format:
      DISK: '/u01/backup/DB180_%F'
    device:
      DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
  DB190:
    archivelog_backup_copies:
      DISK: '1'
    backup_optimization: 'ON'
    controlfile_autobackup: 'ON'
    controlfile_autobackup_format:
      DISK: '/u01/backup/DB190_%F'
    device:
      DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
  DB210:
    archivelog_backup_copies:
      DISK: '1'
    backup_optimization: 'ON'
    controlfile_autobackup: 'ON'
    controlfile_autobackup_format:
      DISK: '/u01/backup/DB210_%F'
    device:
      DISK: 'PARALLELISM 2 BACKUP TYPE TO COMPRESSED BACKUPSET'
```
