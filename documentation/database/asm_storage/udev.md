---
title: database::asm storage::udev
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class will apply udev rules to specified disk devices.

Here is an example:

```puppet
  include ora_profile::database::asm_storage::udev
```




## Attributes



Attribute Name                                                  | Short Description                                                    |
--------------------------------------------------------------- | -------------------------------------------------------------------- |
[disk_devices](#database::asm_storage::udev_disk_devices)       | The disk devices that should be used.                                |
[grid_admingroup](#database::asm_storage::udev_grid_admingroup) | The OS group to use for ASM admin.                                   |
[grid_user](#database::asm_storage::udev_grid_user)             | The name of the user that owns the Grid Infrastructure installation. |




### grid_user<a name='database::asm_storage::udev_grid_user'>

The name of the user that owns the Grid Infrastructure installation.

The default value is: `grid`.
Type: `String[1]`


[Back to overview of database::asm_storage::udev](#attributes)

### grid_admingroup<a name='database::asm_storage::udev_grid_admingroup'>

The OS group to use for ASM admin.

The default value is: `asmadmin`

Type: `String[1]`


[Back to overview of database::asm_storage::udev](#attributes)

### disk_devices<a name='database::asm_storage::udev_disk_devices'>

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

Type: `Hash`


[Back to overview of database::asm_storage::udev](#attributes)
