---
title: database::asm listener
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the Oracle listener process. It installs the specified version of the SQL*net software and start's the listener.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Attributes



Attribute Name                                           | Short Description                                      |
-------------------------------------------------------- | ------------------------------------------------------ |
[dbname](#database::asm_listener_dbname)                 | The name of the database.                              |
[oracle_base](#database::asm_listener_oracle_base)       | The base firectory to use for the Oracle installation. |
[oracle_home](#database::asm_listener_oracle_home)       | The home firectory to use for the Oracle installation. |
[sqlnet_version](#database::asm_listener_sqlnet_version) | The SQLnet version to use.                             |




### oracle_home<a name='database::asm_listener_oracle_home'>

The home firectory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::asm_listener](#attributes)

### oracle_base<a name='database::asm_listener_oracle_base'>

The base firectory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::asm_listener](#attributes)

### sqlnet_version<a name='database::asm_listener_sqlnet_version'>

The SQLnet version to use.

The default is: 12.2
Type: `Ora_install::ShortVersion`


[Back to overview of database::asm_listener](#attributes)

### dbname<a name='database::asm_listener_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database::asm_listener](#attributes)
