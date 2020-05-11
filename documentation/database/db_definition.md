---
title: database::db definition
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the actual database definition using the `ora_database` type. Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                                                                  | Short Description                                                               |
------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
[archivelog](#database::db_definition_archivelog)                               | The database should be running in archivelog mode.                              |
[container_database](#database::db_definition_container_database)               | Database is a container for pluggable databases.                                |
[data_file_destination](#database::db_definition_data_file_destination)         | The location of the datafiles.                                                  |
[db_recovery_file_dest](#database::db_definition_db_recovery_file_dest)         | The location of the Flash Recovery Area.                                        |
[dbdomain](#database::db_definition_dbdomain)                                   | The domain of the database.                                                     |
[dbname](#database::db_definition_dbname)                                       | The name of the database.                                                       |
[init_ora_template](#database::db_definition_init_ora_template)                 | The template to use for the init.ora parameters.                                |
[install_group](#database::db_definition_install_group)                         | The group to use for Oracle install.                                            |
[log_size](#database::db_definition_log_size)                                   | The log ize to use.                                                             |
[ora_database_override](#database::db_definition_ora_database_override)         | A hash with database settings that will override the default database settings. |
[oracle_base](#database::db_definition_oracle_base)                             | The base directory to use for the Oracle installation.                          |
[oracle_home](#database::db_definition_oracle_home)                             | The home directory to use for the Oracle installation.                          |
[os_user](#database::db_definition_os_user)                                     | The OS user to use for Oracle install.                                          |
[sys_password](#database::db_definition_sys_password)                           | The `sys` password to use for the database.                                     |
[sysaux_tablespace_size](#database::db_definition_sysaux_tablespace_size)       | The size for the `SYSAUX` tablespace.                                           |
[system_password](#database::db_definition_system_password)                     | The `system` password to use for the database.                                  |
[system_tablespace_size](#database::db_definition_system_tablespace_size)       | The size for the `SYSTEM` tablespace.                                           |
[temporary_tablespace_size](#database::db_definition_temporary_tablespace_size) | The size for the `TEMP` tablespace.                                             |
[undo_tablespace_size](#database::db_definition_undo_tablespace_size)           | The size for the `UNDO` tablespace.                                             |
[user_tablespace_size](#database::db_definition_user_tablespace_size)           | The size for the `USER` tablespace.                                             |
[version](#database::db_definition_version)                                     | The version of Oracle you want to install.                                      |




### version<a name='database::db_definition_version'>

The version of Oracle you want to install.

The default is : `12.2.0.1`

To customize this consistently use the hiera key `ora_profile::database::version`.

Type: `Ora_Install::Version`


[Back to overview of database::db_definition](#attributes)

### oracle_home<a name='database::db_definition_oracle_home'>

The home directory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_definition](#attributes)

### oracle_base<a name='database::db_definition_oracle_base'>

The base directory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_definition](#attributes)

### os_user<a name='database::db_definition_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### install_group<a name='database::db_definition_install_group'>

The group to use for Oracle install.

The default is : `oinstall`

To customize this consistently use the hiera key `ora_profile::database::install_group`.

Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### dbname<a name='database::db_definition_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### log_size<a name='database::db_definition_log_size'>

The log ize to use.

The default is : `100M`
Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### user_tablespace_size<a name='database::db_definition_user_tablespace_size'>

The size for the `USER` tablespace.

The default value is `50M`
Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### system_tablespace_size<a name='database::db_definition_system_tablespace_size'>

The size for the `SYSTEM` tablespace.

The default value is `50M`
Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### temporary_tablespace_size<a name='database::db_definition_temporary_tablespace_size'>

The size for the `TEMP` tablespace.

The default value is `50M`

Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### undo_tablespace_size<a name='database::db_definition_undo_tablespace_size'>

The size for the `UNDO` tablespace.

The default value is `50M`
Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### sysaux_tablespace_size<a name='database::db_definition_sysaux_tablespace_size'>

The size for the `SYSAUX` tablespace.

The default value is `50M`
Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### system_password<a name='database::db_definition_system_password'>

The `system` password to use for the database.

The default value is: `Welcome01`
Type: `Easy_type::Password`


[Back to overview of database::db_definition](#attributes)

### sys_password<a name='database::db_definition_sys_password'>

The `sys` password to use for the database.

The default value is: `Change_on_1nstall`
Type: `Easy_type::Password`


[Back to overview of database::db_definition](#attributes)

### container_database<a name='database::db_definition_container_database'>

Database is a container for pluggable databases.
When you want to add pluggable database to this database, specify a value of `enabled`.

The default value is: `disabled`

Type: `Enum['enabled','disabled']`


[Back to overview of database::db_definition](#attributes)

### archivelog<a name='database::db_definition_archivelog'>

The database should be running in archivelog mode.

Type: `Enum['enabled','disabled']`


[Back to overview of database::db_definition](#attributes)

### init_ora_template<a name='database::db_definition_init_ora_template'>

The template to use for the init.ora parameters.

The default value is: 'ora_profile/init.ora.erb'
Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### data_file_destination<a name='database::db_definition_data_file_destination'>

The location of the datafiles.

Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### db_recovery_file_dest<a name='database::db_definition_db_recovery_file_dest'>

The location of the Flash Recovery Area.

Type: `String[1]`


[Back to overview of database::db_definition](#attributes)

### ora_database_override<a name='database::db_definition_ora_database_override'>

A hash with database settings that will override the default database settings.

Type: `Hash`


[Back to overview of database::db_definition](#attributes)

### dbdomain<a name='database::db_definition_dbdomain'>

The domain of the database.

The default is `$facts['networking']['domain']`

Type: `String[1]`


[Back to overview of database::db_definition](#attributes)
