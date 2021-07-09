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


The default packages are:

```yaml
ora_profile::database::packages::list:
- binutils.x86_64
- compat-libcap1.x86_64
- compat-libstdc++-33.i686
- compat-libstdc++-33.x86_64
- gcc.x86_64
- gcc-c++.x86_64
- glibc.i686
- glibc.x86_64
- glibc-devel.i686
- glibc-devel.x86_64
- ksh
- libaio.i686
- libaio.x86_64
- libaio-devel.i686
- libaio-devel.x86_64
- libgcc.i686
- libgcc.x86_64
- libstdc++.i686
- libstdc++.x86_64
- libstdc++-devel.i686
- libstdc++-devel.x86_64
- libXi.i686
- libXi.x86_64
- libXtst.i686
- libXtst.x86_64
- make.x86_64
- sysstat.x86_64
```

[Back to overview of database::packages](#attributes)
