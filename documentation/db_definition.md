---
title: db definition
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the actual database definition using the `ora_database` type. Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                                                        | Short Description                                      |
--------------------------------------------------------------------- | ------------------------------------------------------ |
[dbname](#db_definition_dbname)                                       | The name of the database.                              |
[init_ora_template](#db_definition_init_ora_template)                 | The template to use for the init.ora parameters.       |
[log_size](#db_definition_log_size)                                   | The log ize to use.                                    |
[oracle_base](#db_definition_oracle_base)                             | The base firectory to use for the Oracle installation. |
[oracle_home](#db_definition_oracle_home)                             | The home firectory to use for the Oracle installation. |
[sys_password](#db_definition_sys_password)                           | The `sys` password to use for the database.            |
[sysaux_tablespace_size](#db_definition_sysaux_tablespace_size)       | The size for the `SYSAUX` tablespace.                  |
[system_password](#db_definition_system_password)                     | The `system` password to use for the database.         |
[system_tablespace_size](#db_definition_system_tablespace_size)       | The size for the `SYSTEM` tablespace.                  |
[temporary_tablespace_size](#db_definition_temporary_tablespace_size) | The size for the `TEMP` tablespace.                    |
[undo_tablespace_size](#db_definition_undo_tablespace_size)           | The size for the `UNDO` tablespace.                    |
[user_tablespace_size](#db_definition_user_tablespace_size)           | The size for the `USER` tablespace.                    |
[version](#db_definition_version)                                     | The version of Oracle you want to install.             |




### version<a name='db_definition_version'>



The version of Oracle you want to install.

The default is : `12.2.0.1`

To customize this consistenly use the hiera key `ora_profile::database::version`.

[Back to overview of db_definition](#attributes)


### oracle_home<a name='db_definition_oracle_home'>



The home firectory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistenly use the hiera key `ora_profile::database::oracle_home`.


[Back to overview of db_definition](#attributes)


### oracle_base<a name='db_definition_oracle_base'>



The base firectory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistenly use the hiera key `ora_profile::database::install_group`.


[Back to overview of db_definition](#attributes)


### dbname<a name='db_definition_dbname'>



The name of the database.

The default is `DB01`

To customize this consistenly use the hiera key `ora_profile::database::dbname`.
[Back to overview of db_definition](#attributes)


### log_size<a name='db_definition_log_size'>



The log ize to use.

The default is : `100M`
[Back to overview of db_definition](#attributes)


### user_tablespace_size<a name='db_definition_user_tablespace_size'>



The size for the `USER` tablespace.

The default value is `50M`
[Back to overview of db_definition](#attributes)


### system_tablespace_size<a name='db_definition_system_tablespace_size'>



The size for the `SYSTEM` tablespace.

The default value is `50M`
[Back to overview of db_definition](#attributes)


### temporary_tablespace_size<a name='db_definition_temporary_tablespace_size'>



The size for the `TEMP` tablespace.

The default value is `50M`

[Back to overview of db_definition](#attributes)


### undo_tablespace_size<a name='db_definition_undo_tablespace_size'>



The size for the `UNDO` tablespace.

The default value is `50M`
[Back to overview of db_definition](#attributes)


### sysaux_tablespace_size<a name='db_definition_sysaux_tablespace_size'>



The size for the `SYSAUX` tablespace.

The default value is `50M`
[Back to overview of db_definition](#attributes)


### system_password<a name='db_definition_system_password'>



The `system` password to use for the database. 

The default value is: `Welcome01`
[Back to overview of db_definition](#attributes)


### sys_password<a name='db_definition_sys_password'>



The `sys` password to use for the database. 

The default value is: `Change_on_1nstall`
[Back to overview of db_definition](#attributes)


### init_ora_template<a name='db_definition_init_ora_template'>



The template to use for the init.ora parameters.

The default value is: 'ora_profile/init.ora.erb'
[Back to overview of db_definition](#attributes)

