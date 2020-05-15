---
title: oem server::server packages
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the packages you need to have installed on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::oem](./oem_server.html) for an explanation on how to do this.




## Attributes



Attribute Name                            | Short Description                                                              |
----------------------------------------- | ------------------------------------------------------------------------------ |
[list](#oem_server::server_packages_list) | The required packages for a succesfull Oracle Enterprise Manager installation. |




### list<a name='oem_server::server_packages_list'>

The required packages for a succesfull Oracle Enterprise Manager installation.

The defaults are:

```yaml
ora_profile::oem::server_packages::list:
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

[Back to overview of oem_server::server_packages](#attributes)
