---
title: database::asm patches
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for the ASM patches. It also contains the definition of the required `Opatch` version.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Attributes



Attribute Name                                  | Short Description                                         |
----------------------------------------------- | --------------------------------------------------------- |
[grid_home](#database::asm_patches_grid_home)   | The ORACLE_HOME for the Grid Infrastructure installation. |
[logoutput](#database::asm_patches_logoutput)   | log the outputs of Puppet exec or not.                    |
[opversion](#database::asm_patches_opversion)   | The version of OPatch that is needed.                     |
[patch_file](#database::asm_patches_patch_file) | The file containing the required Opatch version.          |
[patch_list](#database::asm_patches_patch_list) | The list of patches to apply.                             |




### grid_home<a name='database::asm_patches_grid_home'>

The ORACLE_HOME for the Grid Infrastructure installation.

The default is : `/u01/app/grid/product/12.2.0.1/grid_home1`

To customize this consistently use the hiera key `ora_profile::database::grid_home`.

Type: `Stdlib::Absolutepath`


[Back to overview of database::asm_patches](#attributes)

### patch_file<a name='database::asm_patches_patch_file'>

The file containing the required Opatch version.

The default value is: `p6880880_121010_Linux-x86-64_12.1.0.1.10`
Type: `String[1]`


[Back to overview of database::asm_patches](#attributes)

### opversion<a name='database::asm_patches_opversion'>

The version of OPatch that is needed. If it is not installed, Puppet will install the specfied version.

The default value is: `12.1.0.1.10`
Type: `String[1]`


[Back to overview of database::asm_patches](#attributes)

### patch_list<a name='database::asm_patches_patch_list'>

The list of patches to apply.

The default value is : `{}`


Type: `Hash`


[Back to overview of database::asm_patches](#attributes)

### logoutput<a name='database::asm_patches_logoutput'>

log the outputs of Puppet exec or not.

When you specify `true` Puppet will log all output of `exec` types.

Valid values are:

- `true`
- `false`
- `on_failure`

Type: `Variant[Boolean,Enum['on_failure']]`

Default:`lookup({name => 'logoutput', default_value => 'on_failure'})`

[Back to overview of database::asm_patches](#attributes)
