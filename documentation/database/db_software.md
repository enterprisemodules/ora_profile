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





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                          | Short Description                                                 |
------------------------------------------------------- | ----------------------------------------------------------------- |
[bash_additions](#database::db_software_bash_additions) | The text to add at the end of the bash_profile.                   |
[bash_profile](#database::db_software_bash_profile)     | Whether or not to deploy bash_profile for $os_user or $grid_user
 |
[database_type](#database::db_software_database_type)   | The type of database to define.                                   |
[dba_group](#database::db_software_dba_group)           | The group to use for Oracle DBA users.                            |
[dirs](#database::db_software_dirs)                     | The directories to create as part of the installation.            |
[file_name](#database::db_software_file_name)           | The file name containing the Oracle database software kit.        |
[oper_group](#database::db_software_oper_group)         | The oper group for the database.                                  |
[oracle_base](#database::db_software_oracle_base)       | The base directory to use for the Oracle installation.            |
[oracle_home](#database::db_software_oracle_home)       | The home directory to use for the Oracle installation.            |
[os_user](#database::db_software_os_user)               | The OS user to use for Oracle install.                            |
[source](#database::db_software_source)                 | The location where the classes can find the software.             |
[version](#database::db_software_version)               | The version of Oracle you want to install.                        |




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

The base directory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_software](#attributes)

### oracle_home<a name='database::db_software_oracle_home'>

The home directory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home` for a single ORACLE_HOME.

This parameter can also be specified as Hash if you need to install multiple ORACLE_HOME's.
The keys of the hash are just a name.
For every key all parameters that are valid for ora_install::installdb can be specified.

For example:

```yaml
ora_profile::database::db_software::oracle_home:
  18cORACLE_HOME1:
    version:     "%{lookup('ora_profile::database::version')}"
    file:        "%{lookup('ora_profile::database::db_software::file_name')}"
    oracle_home: "/u01/app/oracle/product/%{lookup('ora_profile::database::version')}/db_home1"
  18cORACLE_HOME2:
    version:     "%{lookup('ora_profile::database::version')}"
    file:        "%{lookup('ora_profile::database::db_software::file_name')}"
    oracle_home: "/u01/app/oracle/product/%{lookup('ora_profile::database::version')}/db_home2"
  12cR1ORACLE_HOME1:
    version:     12.1.0.2
    file:        linuxamd64_12102_database
    oracle_home: /u01/app/oracle/product/12.1.0.2/db_home1
  12cR1ORACLE_HOME2:
    version:     12.1.0.2
    file:        linuxamd64_12102_database
    oracle_home: /u01/app/oracle/product/12.1.0.2/db_home2
  12cR1ORACLE_HOME3:
    version:     12.1.0.2
    file:        linuxamd64_12102_database
    oracle_home: /u01/app/oracle/product/12.1.0.2/db_home3
  12cR2ORACLE_HOME1:
    version:      12.2.0.1
    file:         linuxx64_12201_database
    oracle_home: /u01/app/oracle/product/12.2.0.1/db_home1
```

Type: `Variant[Stdlib::Absolutepath, Hash]`


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

### bash_additions<a name='database::db_software_bash_additions'>

The text to add at the end of the bash_profile. This parameter will only be used when you have specified `true` for the parameter `bash_profile`

The default value is an empty string.

Type: `String`


[Back to overview of database::db_software](#attributes)
