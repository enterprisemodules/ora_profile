---
title: database::db startup
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for the auto startup of Oracle after a system reboot.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

Also check the set of [common parameters](./common) that is passed to this class.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                   | Short Description                                                                                       |
------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
[db_type](#database::db_startup_db_type)         | The type of the database used to specify if the database should be started by an init script or srvctl. |
[dbname](#database::db_startup_dbname)           | The name of the database.                                                                               |
[limits](#database::db_startup_limits)           | The limits for the systemd service.                                                                     |
[oracle_home](#database::db_startup_oracle_home) | The home directory to use for the Oracle installation.                                                  |




### oracle_home<a name='database::db_startup_oracle_home'>

The home directory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_startup](#attributes)

### dbname<a name='database::db_startup_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database::db_startup](#attributes)

### db_type<a name='database::db_startup_db_type'>

The type of the database used to specify if the database should be started by an init script or srvctl.

Valid values are:
- `grid`
- `database`

The default value is: 'database'

Type: `Enum['database','grid']`


[Back to overview of database::db_startup](#attributes)

### limits<a name='database::db_startup_limits'>

The limits for the systemd service.

The default value is:

```yaml
ora_profile::database::db_startup::limits:
  '*/nofile':
    soft: 2048
    hard: 8192
  'oracle/nofile':
    soft: 65536
    hard: 65536
  'oracle/nproc':
    soft: 2048
    hard: 16384
  'oracle/stack':
    soft: 10240
    hard: 32768
```

Type: `Optional[Hash]`


[Back to overview of database::db_startup](#attributes)
