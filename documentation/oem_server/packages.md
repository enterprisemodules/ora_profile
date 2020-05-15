---
title: oem server::packages
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the packages you need to have installed on your system.




## Attributes



Attribute Name                     | Short Description                                                              |
---------------------------------- | ------------------------------------------------------------------------------ |
[list](#oem_server::packages_list) | The required packages for a succesfull Oracle Enterprise Manager installation. |




### list<a name='oem_server::packages_list'>

The required packages for a succesfull Oracle Enterprise Manager installation.

The defaults are:

```yaml
ora_profile::oem_server::packages::list:
  gcc: {}
  gcc-c++: {}
  dejavu-serif-fonts: {}
  numactl: {}
  numactl-devel: {}
  motif: {}
  motif-devel: {}
  redhat-lsb: {}
  redhat-lsb-core: {}
  openssl: {}
```
Type: `Hash`


[Back to overview of oem_server::packages](#attributes)
