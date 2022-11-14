---
title: database::db listener
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the Oracle listener process. It installs the specified version of the SQL*net software and start's the listener.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.






## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                          | Short Description                                      |
------------------------------------------------------- | ------------------------------------------------------ |
[dba_group](#database::db_listener_dba_group)           | The group to use for Oracle DBA users.                 |
[dbname](#database::db_listener_dbname)                 | The name of the database.                              |
[oracle_base](#database::db_listener_oracle_base)       | The base directory to use for the Oracle installation. |
[oracle_home](#database::db_listener_oracle_home)       | The home directory to use for the Oracle installation. |
[os_user](#database::db_listener_os_user)               | The OS user to use for Oracle install.                 |
[sqlnet_version](#database::db_listener_sqlnet_version) | The SQLnet version to use.                             |




### oracle_home<a name='database::db_listener_oracle_home'>

The home directory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_listener](#attributes)

### oracle_base<a name='database::db_listener_oracle_base'>

The base directory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_listener](#attributes)

### os_user<a name='database::db_listener_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String[1]`


[Back to overview of database::db_listener](#attributes)

### dba_group<a name='database::db_listener_dba_group'>

The group to use for Oracle DBA users.

The default is : `dba`

To customize this consistently use the hiera key `ora_profile::database::dba_group`.

Type: `String[1]`


[Back to overview of database::db_listener](#attributes)

### sqlnet_version<a name='database::db_listener_sqlnet_version'>

The SQLnet version to use.

The default is: 19.0

Type: `Ora_install::ShortVersion`


[Back to overview of database::db_listener](#attributes)

### dbname<a name='database::db_listener_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.

This parameter can also be defined as Hash in case you need multiple listeners.
The keys of the hash are the database names, and for every key you can specify all valid parameters for the class.
The defaults for all key(s) in the Hash are the ones given to the class.

Type: `Variant[String[1],Hash]`


[Back to overview of database::db_listener](#attributes)
