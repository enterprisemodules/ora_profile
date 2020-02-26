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




## Attributes



Attribute Name                                          | Short Description                                                  |
------------------------------------------------------- | ------------------------------------------------------------------ |
[nfs_export](#database::asm_storage_nfs_export)         | The name of the NFS volume that will be mounted to nfs_mountpoint. |
[nfs_files](#database::asm_storage_nfs_files)           | This is an array of NFS files that will be used as ASM disks.      |
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

The default value is: `nfs`.
Type: `Enum['nfs','asmlib','afd','raw']`


[Back to overview of database::asm_storage](#attributes)

### nfs_files<a name='database::asm_storage_nfs_files'>

This is an array of NFS files that will be used as ASM disks.

The default value is:

```yaml
ora_profile::database::asm_storage::nfs_files:
- /home/nfs_server_data/asm_sda_nfs_b1
- /home/nfs_server_data/asm_sda_nfs_b2
- /home/nfs_server_data/asm_sda_nfs_b3
- /home/nfs_server_data/asm_sda_nfs_b4
```

Type: `Optional[Array[Stdlib::Absolutepath]]`


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

### scan_exclude<a name='database::asm_storage_scan_exclude'>

Specify which devices to exclude from scanning for ASMLib.

The default value is: `undef`

Type: `Optional[String[1]]`


[Back to overview of database::asm_storage](#attributes)
