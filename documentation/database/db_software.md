---
title: database::db software
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the Oracle software you want to use on this system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                                        | Short Description                                                 |
----------------------------------------------------- | ----------------------------------------------------------------- |
[bash_profile](#database::db_software_bash_profile)   | Whether or not to deploy bash_profile for $os_user or $grid_user
 |
[database_type](#database::db_software_database_type) | The type of database to define.                                   |
[dba_group](#database::db_software_dba_group)         | The group to use for Oracle DBA users.                            |
[dirs](#database::db_software_dirs)                   | The directories to create as part of the installation.            |
[file_name](#database::db_software_file_name)         | The file name containing the Oracle database software kit.        |
[install_group](#database::db_software_install_group) | The group to use for Oracle install.                              |
[oper_group](#database::db_software_oper_group)       | The oper group for the database.                                  |
[oracle_base](#database::db_software_oracle_base)     | The base firectory to use for the Oracle installation.            |
[oracle_home](#database::db_software_oracle_home)     | The home firectory to use for the Oracle installation.            |
[os_user](#database::db_software_os_user)             | The OS user to use for Oracle install.                            |
[source](#database::db_software_source)               | The location where the classes can find the software.             |
[version](#database::db_software_version)             | The version of Oracle you want to install.                        |




### version<a name='database::db_software_version'>

The version of Oracle you want to install.

The default is : `12.2.0.1`

To customize this consistently use the hiera key `ora_profile::database::version`.

Type: `Ora_Install::Version`


[Back to overview of database::db_software](#attributes)

### database_type<a name='database::db_software_database_type'>

The type of database to define. 

The default value is: `SE2`.
Type: `Enum['SE2', 'SE', 'EE', 'SEONE']`


[Back to overview of database::db_software](#attributes)

### dirs<a name='database::db_software_dirs'>

The directories to create as part of the installation.

The default value is:

```yaml
ora_profile::database::db_software::dirs:
  - /u02
  - /u03
  - /u02/oradata
  - /u03/fast_recovery_area

```
Type: `Array[Stdlib::Absolutepath]`


[Back to overview of database::db_software](#attributes)

### dba_group<a name='database::db_software_dba_group'>

The group to use for Oracle DBA users.

The default is : `dba`

To customize this consistently use the hiera key `ora_profile::database::dba_group`.

Type: `String[1]`


[Back to overview of database::db_software](#attributes)

### install_group<a name='database::db_software_install_group'>

The group to use for Oracle install.

The default is : `oinstall`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


[Back to overview of database::db_software](#attributes)

### oper_group<a name='database::db_software_oper_group'>

The oper group for the database.

The default is : `oper`

Type: `String[1]`


[Back to overview of database::db_software](#attributes)

### os_user<a name='database::db_software_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String[1]`


[Back to overview of database::db_software](#attributes)

### oracle_base<a name='database::db_software_oracle_base'>

The base firectory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_software](#attributes)

### oracle_home<a name='database::db_software_oracle_home'>

The home firectory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_software](#attributes)

### source<a name='database::db_software_source'>

The location where the classes can find the software. 

You can specify a local directory, a Puppet url or an http url.

The default is : `puppet:///modules/software/`

To customize this consistently use the hiera key `ora_profile::database::source`.

Type: `String[1]`


[Back to overview of database::db_software](#attributes)

### file_name<a name='database::db_software_file_name'>

The file name containing the Oracle database software kit.

The default is: `linuxx64_12201_database`
Type: `String[1]`


[Back to overview of database::db_software](#attributes)

### bash_profile<a name='database::db_software_bash_profile'>

Whether or not to deploy bash_profile for $os_user or $grid_user

The default is : `true`

Type: `Boolean`


[Back to overview of database::db_software](#attributes)
