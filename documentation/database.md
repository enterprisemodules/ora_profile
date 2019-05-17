---
title: database
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This is a highly customizable Puppet profile class to define an Oracle database on your system. In it's core just adding:

```
contain ora_profile::database
```

Is enough to get an Oracle 12.2 database running on your system. 

But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.

## Stages

Defining and starting an Oracle database on you system goes through several stages(These are not puppet stages):

- `sysctl`           (Set all required sysctl parameters)
- `limits`           (Set all required OS limits)
- `packages`         (Install all required packages)
- `groups_and_users` (Create required groups and users)
- `firewall`         (Open required firewall rules)
- `asm_storage`      (Setup storage for use with ASM (skipped by default))
- `asm_software`     (Install Grid Infrastructure/ASM (skipped by default))
- `asm_diskgroup`    (Define all requires ASM diskgroups (skipped by default))
- `db_software`      (Install required Oracle database software)
- `db_patches`       (Install specified Opatch version and install specified patches)
- `db_definition`    (Define the database)
- `db_listener`      (Start the Listener)
- `db_services`      (Define Database Services)
- `db_tablespaces`   (Define all required tablespaces)
- `db_profiles`      (Define all required Oracle profiles)
- `db_users`         (Define all required Oracle users)
- `db_startup`       (Make sure the database restarts after a reboot)

All these stages have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 

## before classes

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `limits` is done. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::database::before_sysctl:   my_profile::my_extra_class
```

## after classes

You can do the same when you want to add code after one of the stage classes:

```yaml
ora_profile::database::after_sysctl:   my_profile::my_extra_class
```

## Skipping

Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:

```yaml
ora_profile::database::sysctl:   skip
```

## Replacing

Or provide your own implementation:

```yaml
ora_profile::database::sysctl:   my_profile::my_own_implementation
```

This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.

Look at the description of the stages and their properties.

At this level you can also customize some generic settings. Check the settings for:

- `version`
- `dbname`
- `os_user`
- `dba_group`
- `install_group`
- `source`
- `oracle_base`
- `oracle_home`

Here is an example on how you can do this:

```puppet

class {'ora_profile::database':
  dbname  => 'EM',
  source  => 'http://www.example.com/database_files',
  version => '11.2.0.3',
}

```






## Attributes



Attribute Name                                               | Short Description                                                                           |
------------------------------------------------------------ | ------------------------------------------------------------------------------------------- |
[after_db_definition](#database_after_db_definition)         | The name of the class you want to execute directly **after** the `db_definition` class.     |
[after_db_listener](#database_after_db_listener)             | The name of the class you want to execute directly **after** the `db_listener` class.       |
[after_db_patches](#database_after_db_patches)               | The name of the class you want to execute directly **after** the `db_patches` class.        |
[after_db_profiles](#database_after_db_profiles)             | The name of the class you want to execute directly **after** the `db_profiles` class.       |
[after_db_services](#database_after_db_services)             | The name of the class you want to execute directly **after** the `db_services` class.       |
[after_db_software](#database_after_db_software)             | The name of the class you want to execute directly **after** the `db_software` class.       |
[after_db_startup](#database_after_db_startup)               | The name of the class you want to execute directly **after** the `db_startup` class.        |
[after_db_tablespaces](#database_after_db_tablespaces)       | The name of the class you want to execute directly **after** the `db_tablespaces` class.    |
[after_db_users](#database_after_db_users)                   | The name of the class you want to execute directly **after** the `db_users` class.          |
[after_firewall](#database_after_firewall)                   | The name of the class you want to execute directly **after** the `firewall` class.          |
[after_groups_and_users](#database_after_groups_and_users)   | The name of the class you want to execute directly **after** the `groups_and_users` class.  |
[after_limits](#database_after_limits)                       | The name of the class you want to execute directly **after** the `limits` class.            |
[after_packages](#database_after_packages)                   | The name of the class you want to execute directly **after** the `packages` class.          |
[after_sysctl](#database_after_sysctl)                       | The name of the class you want to execute directly **after** the `sysctl` class.            |
[before_db_definition](#database_before_db_definition)       | The name of the class you want to execute directly **before** the `limits` class.           |
[before_db_listener](#database_before_db_listener)           | The name of the class you want to execute directly **before** the `db_listener` class.      |
[before_db_patches](#database_before_db_patches)             | The name of the class you want to execute directly **before** the `db_patches` class.       |
[before_db_profiles](#database_before_db_profiles)           | The name of the class you want to execute directly **before** the `db_profiles` class.      |
[before_db_services](#database_before_db_services)           | The name of the class you want to execute directly **before** the `db_services` class.      |
[before_db_software](#database_before_db_software)           | The name of the class you want to execute directly **before** the `db_software` class.      |
[before_db_startup](#database_before_db_startup)             | The name of the class you want to execute directly **before** the `db_startup` class.       |
[before_db_tablespaces](#database_before_db_tablespaces)     | The name of the class you want to execute directly **before** the `db_tablespaces` class.   |
[before_db_users](#database_before_db_users)                 | The name of the class you want to execute directly **before** the `db_users` class.         |
[before_firewall](#database_before_firewall)                 | The name of the class you want to execute directly **before** the `firewall` class.         |
[before_groups_and_users](#database_before_groups_and_users) | The name of the class you want to execute directly **before** the `groups_and_users` class. |
[before_limits](#database_before_limits)                     | The name of the class you want to execute directly **before** the `limits` class.           |
[before_packages](#database_before_packages)                 | The name of the class you want to execute directly **before** the `packages` class.         |
[before_sysctl](#database_before_sysctl)                     | The name of the class you want to execute directly **before** the `sysctl` class.           |
[db_control_provider](#database_db_control_provider)         | Which provider should be used for the type db_control.                                      |
[db_definition](#database_db_definition)                     | Use this value if you want to skip or use your own class for stage `db_definition`.         |
[db_listener](#database_db_listener)                         | Use this value if you want to skip or use your own class for stage `db_listener`.           |
[db_patches](#database_db_patches)                           | Use this value if you want to skip or use your own class for stage `db_patches`.            |
[db_profiles](#database_db_profiles)                         | Use this value if you want to skip or use your own class for stage `db_profiles`.           |
[db_services](#database_db_services)                         | Use this value if you want to skip or use your own class for stage `db_services`.           |
[db_software](#database_db_software)                         | Use this value if you want to skip or use your own class for stage `db_software`.           |
[db_startup](#database_db_startup)                           | Use this value if you want to skip or use your own class for stage `db_startup`.            |
[db_tablespaces](#database_db_tablespaces)                   | Use this value if you want to skip or use your own class for stage `db_tablespaces`.        |
[db_users](#database_db_users)                               | Use this value if you want to skip or use your own class for stage `db_users`.              |
[dba_group](#database_dba_group)                             | The group to use for Oracle DBA users.                                                      |
[dbname](#database_dbname)                                   | The name of the database.                                                                   |
[firewall](#database_firewall)                               | Use this value if you want to skip or use your own class for stage `firewall`.              |
[grid_admingroup](#database_grid_admingroup)                 | The OS group to use for ASM admin.                                                          |
[grid_base](#database_grid_base)                             | The directory to use as grid base.                                                          |
[grid_home](#database_grid_home)                             | The oracle home directory to use for the GRID software.                                     |
[grid_user](#database_grid_user)                             | The name of the user that owns the Grid Infrastructure installation.                        |
[groups_and_users](#database_groups_and_users)               | Use this value if you want to skip or use your own class for stage `groups_and_users`.      |
[install_group](#database_install_group)                     | The group to use for Oracle install.                                                        |
[limits](#database_limits)                                   | Use this value if you want to skip or use your own class for stage `limits`.                |
[oracle_base](#database_oracle_base)                         | The base firectory to use for the Oracle installation.                                      |
[oracle_home](#database_oracle_home)                         | The home firectory to use for the Oracle installation.                                      |
[os_user](#database_os_user)                                 | The OS user to use for Oracle install.                                                      |
[packages](#database_packages)                               | Use this value if you want to skip or use your own class for stage `packages`.              |
[source](#database_source)                                   | The location where the classes can find the software.                                       |
[sysctl](#database_sysctl)                                   | Use this value if you want to skip or use your own class for stage `sysctl`.                |
[version](#database_version)                                 | The version of Oracle you want to install.                                                  |




### version<a name='database_version'>

The version of Oracle you want to install.

The default is : `12.2.0.1`

To customize this consistently use the hiera key `ora_profile::database::version`.

Type: `Ora_Install::Version`


[Back to overview of database](#attributes)

### dbname<a name='database_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database](#attributes)

### os_user<a name='database_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String[1]`


[Back to overview of database](#attributes)

### dba_group<a name='database_dba_group'>

The group to use for Oracle DBA users.

The default is : `dba`

To customize this consistently use the hiera key `ora_profile::database::dba_group`.

Type: `String[1]`


[Back to overview of database](#attributes)

### install_group<a name='database_install_group'>

The group to use for Oracle install.

The default is : `oinstall`

To customize this consistently use the hiera key `ora_profile::database::install_group`.

Type: `String[1]`


[Back to overview of database](#attributes)

### source<a name='database_source'>

The location where the classes can find the software. 

You can specify a local directory, a Puppet url or an http url.

The default is : `puppet:///modules/software/`

To customize this consistently use the hiera key `ora_profile::database::source`.

Type: `String[1]`


[Back to overview of database](#attributes)

### oracle_base<a name='database_oracle_base'>

The base firectory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of database](#attributes)

### oracle_home<a name='database_oracle_home'>

The home firectory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database](#attributes)

### grid_user<a name='database_grid_user'>

The name of the user that owns the Grid Infrastructure installation.

The default value is: `grid`.
Type: `String[1]`


[Back to overview of database](#attributes)

### grid_admingroup<a name='database_grid_admingroup'>

The OS group to use for ASM admin.

The default value is: `asmadmin`

Type: `String[1]`


[Back to overview of database](#attributes)

### grid_base<a name='database_grid_base'>

The directory to use as grid base.

The default value is: `/u01/app/grid/admin`

Type: `Stdlib::Absolutepath`


[Back to overview of database](#attributes)

### grid_home<a name='database_grid_home'>

The oracle home directory to use for the GRID software.

The default value is: `/u01/app/grid/product/12.2.0.1/grid_home1`

Type: `Stdlib::Absolutepath`


[Back to overview of database](#attributes)

### sysctl<a name='database_sysctl'>

Use this value if you want to skip or use your own class for stage `sysctl`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::sysctl:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::sysctl:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### limits<a name='database_limits'>

Use this value if you want to skip or use your own class for stage `limits`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::limits:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::limits:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### packages<a name='database_packages'>

Use this value if you want to skip or use your own class for stage `packages`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::packages:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::packages:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### groups_and_users<a name='database_groups_and_users'>

Use this value if you want to skip or use your own class for stage `groups_and_users`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::groups_and_users:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::groups_and_users:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### firewall<a name='database_firewall'>

Use this value if you want to skip or use your own class for stage `firewall`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::firewall:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::firewall:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_software<a name='database_db_software'>

Use this value if you want to skip or use your own class for stage `db_software`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_software:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_software:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_patches<a name='database_db_patches'>

Use this value if you want to skip or use your own class for stage `db_patches`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_patches:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_patches:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_definition<a name='database_db_definition'>

Use this value if you want to skip or use your own class for stage `db_definition`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_definition:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_definition:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_listener<a name='database_db_listener'>

Use this value if you want to skip or use your own class for stage `db_listener`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_listener:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_listener:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_services<a name='database_db_services'>

Use this value if you want to skip or use your own class for stage `db_services`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_services:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_services:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_tablespaces<a name='database_db_tablespaces'>

Use this value if you want to skip or use your own class for stage `db_tablespaces`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_tablespaces:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_tablespaces:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_profiles<a name='database_db_profiles'>

Use this value if you want to skip or use your own class for stage `db_profiles`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_profiles:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_profiles:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_users<a name='database_db_users'>

Use this value if you want to skip or use your own class for stage `db_users`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_users:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_users:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_startup<a name='database_db_startup'>

Use this value if you want to skip or use your own class for stage `db_startup`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_startup:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::db_startup:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_sysctl<a name='database_before_sysctl'>

The name of the class you want to execute directly **before** the `sysctl` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_sysctl:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_limits<a name='database_before_limits'>

The name of the class you want to execute directly **before** the `limits` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_limits:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_packages<a name='database_before_packages'>

The name of the class you want to execute directly **before** the `packages` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_packages:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_groups_and_users<a name='database_before_groups_and_users'>

The name of the class you want to execute directly **before** the `groups_and_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_groups_and_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_firewall<a name='database_before_firewall'>

The name of the class you want to execute directly **before** the `firewall` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_firewall:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_software<a name='database_before_db_software'>

The name of the class you want to execute directly **before** the `db_software` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_software:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_patches<a name='database_before_db_patches'>

The name of the class you want to execute directly **before** the `db_patches` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_patches:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_definition<a name='database_before_db_definition'>

The name of the class you want to execute directly **before** the `limits` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_limits:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_listener<a name='database_before_db_listener'>

The name of the class you want to execute directly **before** the `db_listener` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_listener:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_services<a name='database_before_db_services'>

The name of the class you want to execute directly **before** the `db_services` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_services:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_tablespaces<a name='database_before_db_tablespaces'>

The name of the class you want to execute directly **before** the `db_tablespaces` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_tablespaces:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_profiles<a name='database_before_db_profiles'>

The name of the class you want to execute directly **before** the `db_profiles` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_profiles:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_users<a name='database_before_db_users'>

The name of the class you want to execute directly **before** the `db_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### before_db_startup<a name='database_before_db_startup'>

The name of the class you want to execute directly **before** the `db_startup` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_startup:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_sysctl<a name='database_after_sysctl'>

The name of the class you want to execute directly **after** the `sysctl` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_sysctl:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_limits<a name='database_after_limits'>

The name of the class you want to execute directly **after** the `limits` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_limits:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_packages<a name='database_after_packages'>

The name of the class you want to execute directly **after** the `packages` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_packages:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_groups_and_users<a name='database_after_groups_and_users'>

The name of the class you want to execute directly **after** the `groups_and_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_groups_and_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_firewall<a name='database_after_firewall'>

The name of the class you want to execute directly **after** the `firewall` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_firewall:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_software<a name='database_after_db_software'>

The name of the class you want to execute directly **after** the `db_software` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_software:  my_module::my_class
```


Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_patches<a name='database_after_db_patches'>

The name of the class you want to execute directly **after** the `db_patches` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_patches:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_definition<a name='database_after_db_definition'>

The name of the class you want to execute directly **after** the `db_definition` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_definition:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_listener<a name='database_after_db_listener'>

The name of the class you want to execute directly **after** the `db_listener` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_listener:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_services<a name='database_after_db_services'>

The name of the class you want to execute directly **after** the `db_services` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_services:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_tablespaces<a name='database_after_db_tablespaces'>

The name of the class you want to execute directly **after** the `db_tablespaces` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_tablespaces:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_profiles<a name='database_after_db_profiles'>

The name of the class you want to execute directly **after** the `db_profiles` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_profiles:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_users<a name='database_after_db_users'>

The name of the class you want to execute directly **after** the `db_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### after_db_startup<a name='database_after_db_startup'>

The name of the class you want to execute directly **after** the `db_startup` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_startup:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of database](#attributes)

### db_control_provider<a name='database_db_control_provider'>

Which provider should be used for the type db_control.

The default value is: `sqlplus`
Type: `String[1]`


[Back to overview of database](#attributes)
