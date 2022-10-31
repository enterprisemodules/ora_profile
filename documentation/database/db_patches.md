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

Valid values depend on your database/grid version, but it should like like below:

- `OCT2018RU`
- `JAN2019RU`
- `APR2019RU`
- etc...
Type: `String[1]`


[Back to overview of database::db_patches](#attributes)

### include_ojvm<a name='database::db_patches_include_ojvm'>

Specify if the OJVM patch for the patch level should also be installed.

Default value is: `false`
Type: `Boolean`


[Back to overview of database::db_patches](#attributes)

### patch_file<a name='database::db_patches_patch_file'>

The file containing the required Opatch version.

The default value is: `p6880880_122010_Linux-x86-64`
Type: `String[1]`


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
the same for Oracle versions 12.1 through 19, so it doesn't matter for which Oracle version you have
downloaded it.

The default value is: `12.2.0.1.13`
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
