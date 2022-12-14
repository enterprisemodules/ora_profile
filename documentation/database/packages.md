---
title: database::packages
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition all the packages you need to have installed on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                   | Short Description                                           |
-------------------------------- | ----------------------------------------------------------- |
[list](#database::packages_list) | The required packages for a succesfull Oracle installation. |




### list<a name='database::packages_list'>

The required packages for a succesfull Oracle installation.

You must specify a Hash of [packages](https://puppet.com/docs/puppet/6/types/package.html)

The default packages for a database installation are dependant on the version of your OS.
For a Grid installation additional packages might be required and are specified in the `ora_profile::database::asm_packages::list` Hash for your OS version.

For RedHat 7 / OracleLinux 7 the packages are:

```yaml
ora_profile::database::packages::list:
- bc
- binutils
- compat-libcap1
- compat-libstdc++-33.x86_64
- e2fsprogs.x86_64
- e2fsprogs-libs.x86_64
- glibc.x86_64
- glibc-devel.x86_64
- ksh
- libaio.x86_64
- libaio-devel.x86_64
- libX11.x86_64
- libXau.x86_64
- libXi.x86_64
- libXtst.x86_64
- libgcc.x86_64
- libstdc++.x86_64
- libstdc++-devel.x86_64
- libxcb.x86_64
- libXrender.x86_64
- libXrender-devel.x86_64
- make.x86_64
- policycoreutils.x86_64
- policycoreutils-python.x86_64
- smartmontools.x86_64
- sysstat.x86_64
```

For RedHat 8 / OracleLinux 8 the packages are:

```yaml
ora_profile::database::packages::list:
- binutils.x86_64
- glibc.x86_64
- glibc-devel.x86_64
- ksh
- libaio.x86_64
- libaio-devel.x86_64
- libgcc.x86_64
- libstdc++.x86_64
- libstdc++-devel.x86_64
- libXi.x86_64
- libXtst.x86_64
- make.x86_64
- sysstat.x86_64
- unzip.x86_64
- psmisc
- libnsl
- libnsl2
```

[Back to overview of database::packages](#attributes)
