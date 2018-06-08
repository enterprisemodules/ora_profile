---
title: asm storage
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class sets up the storage for usage by ASM.
Currently only NFS is supported as storage_type. ASMLIB and AFD will be added in a future release.
Here you can customize some of the attributes of your storage.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                                  | Short Description                                                    |
----------------------------------------------- | -------------------------------------------------------------------- |
[grid_admingroup](#asm_storage_grid_admingroup) | This is the name of the group that will have the NFS files for ASM.  |
[grid_user](#asm_storage_grid_user)             | The name of the user that owns the Grid Infrastructure installation. |
[nfs_export](#asm_storage_nfs_export)           | The name of the NFS volume that will be mounted to nfs_mountpoint.   |
[nfs_files](#asm_storage_nfs_files)             | This is an array of NFS files that will be used as ASM disks.        |
[nfs_mountpoint](#asm_storage_nfs_mountpoint)   | The mountpoint where the NFS volume will be mounted.                 |
[nfs_server](#asm_storage_nfs_server)           | The name of the NFS server.                                          |
[storage_type](#asm_storage_storage_type)       | The type of ASM storage to use.                                      |




### storage_type<a name='asm_storage_storage_type'>

The type of ASM storage to use.
Currently only NFS is supported, ASMLIB and AFD will be added in a future release.

The default value is: `nfs`.
Type: `Enum['nfs','asmlib','afd']`


[Back to overview of asm_storage](#attributes)

### grid_user<a name='asm_storage_grid_user'>

The name of the user that owns the Grid Infrastructure installation.

The default value is: `grid`.
Type: `String[1]`


[Back to overview of asm_storage](#attributes)

### grid_admingroup<a name='asm_storage_grid_admingroup'>

This is the name of the group that will have the NFS files for ASM.

The default value is: `asmadmin`.
Type: `String[1]`


[Back to overview of asm_storage](#attributes)

### nfs_files<a name='asm_storage_nfs_files'>

This is an array of NFS files that will be used as ASM disks.

The default value is:

```yaml
ora_profile::database::asm_storage::nfs_files:
- /home/nfs_server_data/asm_sda_nfs_b1
- /home/nfs_server_data/asm_sda_nfs_b2
- /home/nfs_server_data/asm_sda_nfs_b3
- /home/nfs_server_data/asm_sda_nfs_b4
```
Type: `Array[Stdlib::Absolutepath]`


[Back to overview of asm_storage](#attributes)

### nfs_mountpoint<a name='asm_storage_nfs_mountpoint'>

The mountpoint where the NFS volume will be mounted.

The default value is: `/nfs_client`.
Type: `Stdlib::Absolutepath`


[Back to overview of asm_storage](#attributes)

### nfs_export<a name='asm_storage_nfs_export'>

The name of the NFS volume that will be mounted to nfs_mountpoint.

The default value is: `/home/nfs_server_data`.
Type: `Stdlib::Absolutepath`


[Back to overview of asm_storage](#attributes)

### nfs_server<a name='asm_storage_nfs_server'>

The name of the NFS server.

The default value is: `localhost`.
Type: `String[1]`


[Back to overview of asm_storage](#attributes)
