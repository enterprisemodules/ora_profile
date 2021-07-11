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

Also check the set of [common parameters](./common) that is passed to this class.






## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                  | Short Description                                                         |
----------------------------------------------- | ------------------------------------------------------------------------- |
[level](#database::asm_patches_level)           | The patch level the database or grid infrastructure should be patched to. |
[logoutput](#database::asm_patches_logoutput)   | log the outputs of Puppet exec or not.                                    |
[opversion](#database::asm_patches_opversion)   | The version of OPatch that is needed.                                     |
[patch_file](#database::asm_patches_patch_file) | The file containing the required Opatch version.                          |
[patch_list](#database::asm_patches_patch_list) | The list of patches to apply.                                             |




### level<a name='database::asm_patches_level'>

The patch level the database or grid infrastructure should be patched to.

Default value is: `NONE`

Valid values depend on your database/grid version, but it should like like below:

- `OCT2018RU`
- `JAN2019RU`
- `APR2019RU`
- etc...
Type: `String[1]`


[Back to overview of database::asm_patches](#attributes)

### patch_file<a name='database::asm_patches_patch_file'>

The file containing the required Opatch version.

The default value is: `p6880880_122010_Linux-x86-64`
Type: `String[1]`


[Back to overview of database::asm_patches](#attributes)

### opversion<a name='database::asm_patches_opversion'>

The version of OPatch that is needed. If it is not installed, Puppet will install the specfied version.

The default value is: `12.2.0.1.13`
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
