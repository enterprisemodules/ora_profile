---
title: asm software
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the code to install Oracle Grid Infrastructure.
Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                                     | Short Description                                                     |
-------------------------------------------------- | --------------------------------------------------------------------- |
[asm_sys_password](#asm_software_asm_sys_password) | The `sys` password to use for ASM.                                    |
[dirs](#asm_software_dirs)                         | The directories to create as part of the installation.                |
[file_name](#asm_software_file_name)               | The file name containing the Oracle Grid Infrastructure software kit. |
[grid_base](#asm_software_grid_base)               | The ORACLE_BASE for the Grid Infrastructure installation.             |
[grid_group](#asm_software_grid_group)             | The primary group of the owner(grid_user) of the installation.        |
[grid_home](#asm_software_grid_home)               | The ORACLE_HOME for the Grid Infrastructure installation.             |
[grid_user](#asm_software_grid_user)               | The name of the user that owns the Grid Infrastructure installation.  |
[source](#asm_software_source)                     | The location where the classes can find the software.                 |
[version](#asm_software_version)                   | The version of Oracle Grid Infrastructure you want to install.        |




### version<a name='asm_software_version'>

The version of Oracle Grid Infrastructure you want to install.

The default is : `12.2.0.1`

To customize this consistently use the hiera key `ora_profile::database::asm_software::version`.

Type: `Enum['12.2.0.1','12.1.0.1','12.1.0.2','11.2.0.4']`


[Back to overview of asm_software](#attributes)

### dirs<a name='asm_software_dirs'>

The directories to create as part of the installation.

The default value is:

```yaml
ora_profile::database::asm_software::dirs:
- /u01
- /u01/app/grid
- /u01/app/grid/admin
- /u01/app/grid/product

```
Type: `Array[Stdlib::Absolutepath]`


[Back to overview of asm_software](#attributes)

### grid_user<a name='asm_software_grid_user'>

The name of the user that owns the Grid Infrastructure installation.

The default value is: `grid`.
Type: `String[1]`


[Back to overview of asm_software](#attributes)

### grid_group<a name='asm_software_grid_group'>

The primary group of the owner(grid_user) of the installation.

The default is : `oinstall`

To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_group`.

Type: `String[1]`


[Back to overview of asm_software](#attributes)

### grid_base<a name='asm_software_grid_base'>

The ORACLE_BASE for the Grid Infrastructure installation.

The default is : `/u01/app/grid/admin`

To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_base`.

Type: `Stdlib::Absolutepath`


[Back to overview of asm_software](#attributes)

### grid_home<a name='asm_software_grid_home'>

The ORACLE_HOME for the Grid Infrastructure installation.

The default is : `/u01/app/grid/product/12.2.0.1/grid_home1`

To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_home`.

Type: `Stdlib::Absolutepath`


[Back to overview of asm_software](#attributes)

### source<a name='asm_software_source'>

The location where the classes can find the software. 

You can specify a local directory, a Puppet url or an http url.

The default is : `puppet:///modules/software/`

To customize this consistently use the hiera key `ora_profile::database::source`.

Type: `String[1]`


[Back to overview of asm_software](#attributes)

### file_name<a name='asm_software_file_name'>

The file name containing the Oracle Grid Infrastructure software kit.

The default is: `linuxx64_12201_grid_home`
Type: `String[1]`


[Back to overview of asm_software](#attributes)

### asm_sys_password<a name='asm_software_asm_sys_password'>

The `sys` password to use for ASM.

The default is: `Welcome01`
Type: `String[1]`


[Back to overview of asm_software](#attributes)
