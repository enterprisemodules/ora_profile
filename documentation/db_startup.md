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



Attribute Name                         | Short Description                                      |
-------------------------------------- | ------------------------------------------------------ |
[dbname](#db_startup_dbname)           | The name of the database.                              |
[oracle_home](#db_startup_oracle_home) | The home firectory to use for the Oracle installation. |




### oracle_home<a name='db_startup_oracle_home'>



The home firectory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistenly use the hiera key `ora_profile::database::oracle_home`.


[Back to overview of db_startup](#attributes)


### dbname<a name='db_startup_dbname'>



The name of the database.

The default is `DB01`

To customize this consistenly use the hiera key `ora_profile::database::dbname`.
[Back to overview of db_startup](#attributes)

