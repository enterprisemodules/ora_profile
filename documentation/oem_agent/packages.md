---
title: oem agent::packages
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the packages you need to have installed on your system.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                    | Short Description                                                                    |
--------------------------------- | ------------------------------------------------------------------------------------ |
[list](#oem_agent::packages_list) | The required packages for a succesfull Oracle Enterprise Manager Agent installation. |




### list<a name='oem_agent::packages_list'>

The required packages for a succesfull Oracle Enterprise Manager Agent installation.

The defaults are:

```yaml
ora_profile::oem_agent::packages::list:
  make: {}
  binutils: {}
  gcc: {}
  libaio: {}
  glibc-common: {}
  libstdc++: {}
  sysstat: {}
```


[Back to overview of oem_agent::packages](#attributes)
