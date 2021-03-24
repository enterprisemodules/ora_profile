---
title: database::asm storage::nfs
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class will create the specified mountpoint and mount the nfs share there.

Here is an example:

```puppet
  include ora_profile::database::asm_storage::nfs
```




If you want to play and experiment with this type, please take a look at our playgrounds. At our playgrounds, 
we provide you with a pre-installed environment, where you experiment with these Puppet types.

Look at our playgrounds [here](/playgrounds#oracle)

## Attributes



Attribute Name                                                 | Short Description                                                    |
-------------------------------------------------------------- | -------------------------------------------------------------------- |
[grid_admingroup](#database::asm_storage::nfs_grid_admingroup) | The OS group to use for ASM admin.                                   |
[grid_user](#database::asm_storage::nfs_grid_user)             | The name of the user that owns the Grid Infrastructure installation. |
[nfs_export](#database::asm_storage::nfs_nfs_export)           | The name of the NFS volume that will be mounted to nfs_mountpoint.   |
[nfs_mountpoint](#database::asm_storage::nfs_nfs_mountpoint)   | The mountpoint where the NFS volume will be mounted.                 |
[nfs_server](#database::asm_storage::nfs_nfs_server)           | The name of the NFS server.                                          |




### grid_user<a name='database::asm_storage::nfs_grid_user'>

The name of the user that owns the Grid Infrastructure installation.

The default value is: `grid`.
Type: `String[1]`


[Back to overview of database::asm_storage::nfs](#attributes)

### grid_admingroup<a name='database::asm_storage::nfs_grid_admingroup'>

The OS group to use for ASM admin.

The default value is: `asmadmin`

Type: `String[1]`


[Back to overview of database::asm_storage::nfs](#attributes)

### nfs_mountpoint<a name='database::asm_storage::nfs_nfs_mountpoint'>

The mountpoint where the NFS volume will be mounted.

The default value is: `/nfs_client`.
Type: `Stdlib::Absolutepath`


[Back to overview of database::asm_storage::nfs](#attributes)

### nfs_export<a name='database::asm_storage::nfs_nfs_export'>

The name of the NFS volume that will be mounted to nfs_mountpoint.

The default value is: `/home/nfs_server_data`.
Type: `Stdlib::Absolutepath`


[Back to overview of database::asm_storage::nfs](#attributes)

### nfs_server<a name='database::asm_storage::nfs_nfs_server'>

The name of the NFS server.

The default value is: `localhost`.
Type: `String[1]`


[Back to overview of database::asm_storage::nfs](#attributes)
