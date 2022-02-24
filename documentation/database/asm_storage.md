---
title: database::asm storage
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class sets up the storage for usage by ASM.
Here you can customize some of the attributes of your storage.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                          | Short Description                                                  |
------------------------------------------------------- | ------------------------------------------------------------------ |
[disk_devices](#database::asm_storage_disk_devices)     | The disk devices that should be used.                              |
[nfs_export](#database::asm_storage_nfs_export)         | The name of the NFS volume that will be mounted to nfs_mountpoint. |
[nfs_mountpoint](#database::asm_storage_nfs_mountpoint) | The mountpoint where the NFS volume will be mounted.               |
[nfs_server](#database::asm_storage_nfs_server)         | The name of the NFS server.                                        |
[scan_exclude](#database::asm_storage_scan_exclude)     | Specify which devices to exclude from scanning for ASMLib.         |
[storage_type](#database::asm_storage_storage_type)     | The type of ASM storage to use.                                    |




### storage_type<a name='database::asm_storage_storage_type'>

The type of ASM storage to use.

Valid values are:
- `nfs`
- `asmlib`
- `afd`
- `raw`
- `none`

The default value is: `nfs`.
Type: `Enum['nfs','asmlib','afd','raw','none']`


[Back to overview of database::asm_storage](#attributes)

### nfs_mountpoint<a name='database::asm_storage_nfs_mountpoint'>

The mountpoint where the NFS volume will be mounted.

The default value is: `/nfs_client`.
Type: `Optional[Stdlib::Absolutepath]`


[Back to overview of database::asm_storage](#attributes)

### nfs_export<a name='database::asm_storage_nfs_export'>

The name of the NFS volume that will be mounted to nfs_mountpoint.

The default value is: `/home/nfs_server_data`.
Type: `Optional[Stdlib::Absolutepath]`


[Back to overview of database::asm_storage](#attributes)

### nfs_server<a name='database::asm_storage_nfs_server'>

The name of the NFS server.

The default value is: `localhost`.
Type: `Optional[String[1]]`


[Back to overview of database::asm_storage](#attributes)

### disk_devices<a name='database::asm_storage_disk_devices'>

The disk devices that should be used.
Dependant on value specified for `ora_profile::database::asm_storage::storage_type`

Here is an example:

```yaml
ora_profile::database::asm_storage::disk_devices:
  asm_data01:
    size: 8192
    uuid: '1ATA_VBOX_HARDDISK_VB00000000-01000000'
    label: 'DATA1'
```

Type: `Optional[Hash]`


[Back to overview of database::asm_storage](#attributes)

### scan_exclude<a name='database::asm_storage_scan_exclude'>

Specify which devices to exclude from scanning for ASMLib.

The default value is: `undef`

Type: `Optional[String[1]]`


[Back to overview of database::asm_storage](#attributes)
