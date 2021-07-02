---
title: database::sysctl
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition all all required sysctl setings for your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                 | Short Description                          |
------------------------------ | ------------------------------------------ |
[list](#database::sysctl_list) | The required sysctl parameters for Oracle. |




### list<a name='database::sysctl_list'>

The required sysctl parameters for Oracle.

The defaults are:

```yaml
ora_profile::database::sysctl::list:
  'kernel.msgmnb':
    value:  65536
  'kernel.msgmax':
    value:  65536
  'kernel.shmmax':
    value:  4398046511104
  'kernel.shmall':
    value:  4294967296
  'fs.file-max':
    value:  6815744
  'kernel.shmmni':
    value:  4096
  'fs.aio-max-nr':
    value:  1048576
  'kernel.sem':
    value:  '250 32000 100 128'
  'net.ipv4.ip_local_port_range':
    value:  '9000 65500'
  'net.core.rmem_default':
    value:  262144
  'net.core.rmem_max':
    value:  4194304
  'net.core.wmem_default':
    value:  262144
  'net.core.wmem_max':
    value:  1048576
  'kernel.panic_on_oops':
    value:  1
```

[Back to overview of database::sysctl](#attributes)
