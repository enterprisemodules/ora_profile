---
title: db patches
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for the Oracle patches. It also contains the definition of the required `Opatch` version.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Attributes



Attribute Name                             | Short Description                                      |
------------------------------------------ | ------------------------------------------------------ |
[install_group](#db_patches_install_group) | The group to use for Oracle install.                   |
[opversion](#db_patches_opversion)         | The version of OPatch that is needed.                  |
[oracle_home](#db_patches_oracle_home)     | The home firectory to use for the Oracle installation. |
[os_user](#db_patches_os_user)             | The OS user to use for Oracle install.                 |
[patch_file](#db_patches_patch_file)       | The file containing the required Opatch version.       |
[patch_list](#db_patches_patch_list)       | The list of patches to apply.                          |
[source](#db_patches_source)               | The location where the classes can find the software.  |




### patch_file<a name='db_patches_patch_file'>

The file containing the required Opatch version.

The default value is: `p6880880_121010_Linux-x86-64_12.1.0.1.10`
Type: `String[1]`


[Back to overview of db_patches](#attributes)

### oracle_home<a name='db_patches_oracle_home'>

The home firectory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of db_patches](#attributes)

### opversion<a name='db_patches_opversion'>

The version of OPatch that is needed. If it is not installed, Puppet will install the specfied version.

The default value is: `12.1.0.1.10`
Type: `String[1]`


[Back to overview of db_patches](#attributes)

### install_group<a name='db_patches_install_group'>

The group to use for Oracle install.

The default is : `oinstall`

To customize this consistently use the hiera key `ora_profile::database::install_group`.

Type: `String[1]`


[Back to overview of db_patches](#attributes)

### os_user<a name='db_patches_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String[1]`


[Back to overview of db_patches](#attributes)

### source<a name='db_patches_source'>

The location where the classes can find the software. 

You can specify a local directory, a Puppet url or an http url.

The default is : `puppet:///modules/software/`

To customize this consistently use the hiera key `ora_profile::database::source`.

Type: `String[1]`


[Back to overview of db_patches](#attributes)

### patch_list<a name='db_patches_patch_list'>

The list of patches to apply.

The default value is : `{}`


Type: `Hash`


[Back to overview of db_patches](#attributes)
