---
title: db startup
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for the auto startup of Oracle after a system reboot.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                         | Short Description                                                                                       |
-------------------------------------- | ------------------------------------------------------------------------------------------------------- |
[db_type](#db_startup_db_type)         | The type of the database used to specify if the database should be started by an init script or srvctl. |
[dbname](#db_startup_dbname)           | The name of the database.                                                                               |
[oracle_home](#db_startup_oracle_home) | The home firectory to use for the Oracle installation.                                                  |




### oracle_home<a name='db_startup_oracle_home'>

The home firectory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of db_startup](#attributes)

### dbname<a name='db_startup_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of db_startup](#attributes)

### db_type<a name='db_startup_db_type'>

The type of the database used to specify if the database should be started by an init script or srvctl.

Valid values are:
- `grid`
- `database`

The default value is: 'database'

Type: `Optional[Enum['database','grid']]`

Default:`'database'`

[Back to overview of db_startup](#attributes)
