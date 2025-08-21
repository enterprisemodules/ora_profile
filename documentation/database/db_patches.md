---
title: database::db patches
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for the Oracle patches. It also contains the definition of the required `Opatch` version.

The class allows you to specify a patch level and optionally include the OJVM pacthes for the level specified.
A patch_list to specify additional patches is also supported.

Keep in mind that when changing the patch level and/or adding patches will cause the listener(s) and database(s) to be stopped and started.

Applying patches to database software in a RAC environment is only supported on initial run.
There is no support yet to apply patches on a running system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

Also check the set of [common parameters](./common) that is passed to this class.







## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                     | Short Description                                                         |
-------------------------------------------------- | ------------------------------------------------------------------------- |
[include_ojvm](#database::db_patches_include_ojvm) | Specify if the OJVM patch for the patch level should also be installed.   |
[level](#database::db_patches_level)               | The patch level the database or grid infrastructure should be patched to. |
[logoutput](#database::db_patches_logoutput)       | log the outputs of Puppet exec or not.                                    |
[opversion](#database::db_patches_opversion)       | The version of OPatch that is needed.                                     |
[oracle_home](#database::db_patches_oracle_home)   | The home directory to use for the Oracle installation.                    |
[os_user](#database::db_patches_os_user)           | The OS user to use for Oracle install.                                    |
[patch_file](#database::db_patches_patch_file)     | The file containing the required Opatch version.                          |
[patch_list](#database::db_patches_patch_list)     | The list of patches to apply.                                             |




### level<a name='database::db_patches_level'>

The patch level the database or grid infrastructure should be patched to.

Default value is: `NONE`

The value can be a String or a Hash. When the value is a string, the current selected Oracle version (e.g. `ora_profile::database::version`) and the current selected oracle home (e.g. `ora_profile::database::oracle_home`) are used to apply the patch.

When you specify a Hash, it must have the following format:

```
ora_profile::database::db_patches::level:
  21cDEFAULT_HOME:
    version:     21.0.0.0
    oracle_home: /u01/app/oracle/product/21.0.0.0/db_home1
    level:       OCT2022RU
  19cDEFAULT_HOME:
    version:     19.0.0.0
    oracle_home: /u01/app/oracle/product/19.0.0.0/db_home1
    level:       OCT2022RU
  18cADDITIONAL_HOME:
    version:     18.0.0.0
    oracle_home: /u01/app/oracle/product/18.0.0.0/db_home1
    level:       APR2021RU
  12cR2ADDITIONAL_HOME:
    version:     12.2.0.1
    oracle_home: /u01/app/oracle/product/12.2.0.1/db_home1
    level:       JAN2022RU
```
When no level is specified, the level `NONE` is inferred and no level of patches are applied. You can alywas use `patch_list` to specify a specific list of patches to be applied.

Type: `Variant[String[1],Hash]`


[Back to overview of database::db_patches](#attributes)

### include_ojvm<a name='database::db_patches_include_ojvm'>

Specify if the OJVM patch for the patch level should also be installed.

Default value is: `false`
Type: `Boolean`


[Back to overview of database::db_patches](#attributes)

### patch_file<a name='database::db_patches_patch_file'>

The file containing the required Opatch version.

The default value is: `p6880880_122010_Linux-x86-64`

The value can be a String or a Hash. When the value is a string, the file specified will be used to upgrade OPatch in every ORACLE_HOME on the system.
If you want to install different versions in different ORACLE_HOME's you can specify a patch_file per ORACLE_HOME like below.

When you specify a Hash, it must have the following format:

```yaml
ora_profile::database::db_patches::patch_file:
  /u01/app/oracle/product/23.0.0.0/db_home1:
    patch_file: p6880880_230000_Linux-x86-64-12.2.0.1.48
  /u01/app/oracle/product/21.0.0.0/db_home1:
    patch_file: p6880880_210000_Linux-x86-64
    opversion:  12.2.0.1.35
  /u01/app/oracle/product/19.0.0.0/db_home1
    patch_file: p6880880_190000_Linux-x86-64
    opversion:  12.2.0.1.37
  /u01/app/oracle/product/18.0.0.0/db_home1
    patch_file: p6880880_180000_Linux-x86-64
  /u01/app/oracle/product/12.2.0.1/db_home1:
    patch_file: p6880880_122010_Linux-x86-64-12.2.0.1.21
    opversion:  12.2.0.1.21
```

Type: `Variant[String[1],Hash[Stdlib::Absolutepath,Struct[{patch_file=>String[1],opversion=>Optional[String[1]]}]]]`


[Back to overview of database::db_patches](#attributes)

### oracle_home<a name='database::db_patches_oracle_home'>

The home directory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_patches](#attributes)

### opversion<a name='database::db_patches_opversion'>

The version of OPatch that is needed. If it is not installed, Puppet will install the specfied version.
If you have defined patches for multiple homes, this version of the OPatch utility will be installed
in all of these homes from the patch_file specified. Recent versions of the OPatch utility are exactly
the same for Oracle versions 12.1 through 21, so it doesn't matter for which Oracle version you have
downloaded it.

The default value is: `12.2.0.1.33`
Type: `String[1]`


[Back to overview of database::db_patches](#attributes)

### os_user<a name='database::db_patches_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String[1]`


[Back to overview of database::db_patches](#attributes)

### patch_list<a name='database::db_patches_patch_list'>

The list of patches to apply.

The default value is : `{}`


Type: `Hash`


[Back to overview of database::db_patches](#attributes)

### logoutput<a name='database::db_patches_logoutput'>

log the outputs of Puppet exec or not.

When you specify `true` Puppet will log all output of `exec` types.

Valid values are:

- `true`
- `false`
- `on_failure`

Type: `Variant[Boolean,Enum['on_failure']]`

Default:`lookup({ name => 'logoutput', default_value => 'on_failure' })`

[Back to overview of database::db_patches](#attributes)
