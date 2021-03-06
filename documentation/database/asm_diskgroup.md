---
title: database::asm diskgroup
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the code to create the ASM diskgroups. Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                          | Short Description                                |
--------------------------------------- | ------------------------------------------------ |
[disks](#database::asm_diskgroup_disks) | A hash with the diskgroups that will be created. |




### disks<a name='database::asm_diskgroup_disks'>

A hash with the diskgroups that will be created.

The default value is:

```yaml
ora_profile::database::asm_diskgroup::disks:
  DATA:
    disks:
    - diskname: 'DATA_0000'
      path: '/nfs_client/asm_sda_nfs_b1'
    - diskname: 'DATA_0001'
      path: '/nfs_client/asm_sda_nfs_b2'
  RECO:
    disks:
    - diskname: 'RECO_0000'
      path: '/nfs_client/asm_sda_nfs_b3'
    - diskname: 'RECO_0001'
      path: '/nfs_client/asm_sda_nfs_b4'

```
Type: `Hash`

Default:`{}`

[Back to overview of database::asm_diskgroup](#attributes)
