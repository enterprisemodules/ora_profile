---
title: database::rman config
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for all the tablespaces you'd like on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                              | Short Description                                   |
------------------------------------------- | --------------------------------------------------- |
[settings](#database::rman_config_settings) | The settings you wish to apply on your database(s). |




### settings<a name='database::rman_config_settings'>

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

Type: `Hash`


[Back to overview of database::rman_config](#attributes)
