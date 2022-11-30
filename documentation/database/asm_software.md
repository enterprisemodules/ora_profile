---
title: database::asm software
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the code to install Oracle Grid Infrastructure.
Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                                           | Short Description                                                        |
------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
[asm_diskgroup](#database::asm_software_asm_diskgroup)                   | The name of the ASM diskgroup to use.                                    |
[asm_disks](#database::asm_software_asm_disks)                           | List of disks to create a ASM DiskGroup.                                 |
[asm_group](#database::asm_software_asm_group)                           | The admin group for ASM.                                                 |
[asm_sys_password](#database::asm_software_asm_sys_password)             | The `sys` password to use for ASM.                                       |
[bash_additions](#database::asm_software_bash_additions)                 | The text to add at the end of the bash_profile.                          |
[bash_profile](#database::asm_software_bash_profile)                     | Whether or not to deploy bash_profile for $os_user or $grid_user
        |
[cluster_name](#database::asm_software_cluster_name)                     | The name of the cluster.                                                 |
[cluster_node_types](#database::asm_software_cluster_node_types)         | The names of the nodes in the RAC cluster.                               |
[configure_afd](#database::asm_software_configure_afd)                   | Specify whether or not to configure ASM Filter Driver instead of ASMLib. |
[dirs](#database::asm_software_dirs)                                     | The directories to create as part of the installation.                   |
[disk_discovery_string](#database::asm_software_disk_discovery_string)   | The disk discovery string for ASM.                                       |
[disk_redundancy](#database::asm_software_disk_redundancy)               | The disk redundancy for the initial diskgroup to setup ASM.              |
[disks_failgroup_names](#database::asm_software_disks_failgroup_names)   | A comma seperated list of device and failure group name.                 |
[file_name](#database::asm_software_file_name)                           | The file name containing the Oracle Grid Infrastructure software kit.    |
[grid_type](#database::asm_software_grid_type)                           | The type of grid.                                                        |
[group](#database::asm_software_group)                                   | The dba group for ASM.                                                   |
[install_task](#database::asm_software_install_task)                     | The installation task that should be executed.                           |
[network_interface_list](#database::asm_software_network_interface_list) | The list of interfaces to use for RAC.                                   |
[oper_group](#database::asm_software_oper_group)                         | The oper group for ASM.                                                  |
[scan_name](#database::asm_software_scan_name)                           | The hostname to use for the SCAN service.                                |
[scan_port](#database::asm_software_scan_port)                           | The IP portnumber to use for the SCAN service.                           |
[storage_option](#database::asm_software_storage_option)                 | The type of storage to use.                                              |
[version](#database::asm_software_version)                               | The version of Oracle Grid Infrastructure you want to install.           |




### version<a name='database::asm_software_version'>

The version of Oracle Grid Infrastructure you want to install.

The default is : `19.0.0.0`

To customize this consistently use the hiera key `ora_profile::database::asm_software::version`.

Type: `Ora_Install::Version`


[Back to overview of database::asm_software](#attributes)

### dirs<a name='database::asm_software_dirs'>

The directories to create as part of the installation.

The default value is:

```yaml
ora_profile::database::asm_software::dirs:
- /u01
- /u01/app/grid
- /u01/app/grid/admin
- /u01/app/grid/product

```
Type: `Array[Stdlib::Absolutepath]`


[Back to overview of database::asm_software](#attributes)

### file_name<a name='database::asm_software_file_name'>

The file name containing the Oracle Grid Infrastructure software kit.

The default is: `linuxx64_12201_grid_home`

Type: `String[1]`


[Back to overview of database::asm_software](#attributes)

### asm_sys_password<a name='database::asm_software_asm_sys_password'>

The `sys` password to use for ASM.

The default is: `Welcome01`

To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_sys_password`.

Type: `Easy_type::Password`


[Back to overview of database::asm_software](#attributes)

### disk_discovery_string<a name='database::asm_software_disk_discovery_string'>

The disk discovery string for ASM.

The default value is: `/nfs_client/asm*`

To customize this consistently use the hiera key `ora_profile::database::asm_software::disk_discovery_string`.

Type: `String[1]`


[Back to overview of database::asm_software](#attributes)

### asm_diskgroup<a name='database::asm_software_asm_diskgroup'>

The name of the ASM diskgroup to use.

The default value is: `DATA`


To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_diskgroup`.

Type: `String[1]`


[Back to overview of database::asm_software](#attributes)

### asm_disks<a name='database::asm_software_asm_disks'>

List of disks to create a ASM DiskGroup.

The default value is: `/nfs_client/asm_sda_nfs_b1,/nfs_client/asm_sda_nfs_b2`

To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_disks`.

Type: `String[1]`


[Back to overview of database::asm_software](#attributes)

### group<a name='database::asm_software_group'>

The dba group for ASM.

The default is : `asmdba`

To customize this consistently use the hiera key `ora_profile::database::asm_software::group`.

Type: `String[1]`


[Back to overview of database::asm_software](#attributes)

### oper_group<a name='database::asm_software_oper_group'>

The oper group for ASM.

The default is : `asmoper`

To customize this consistently use the hiera key `ora_profile::database::asm_software::oper_group`.

Type: `String[1]`


[Back to overview of database::asm_software](#attributes)

### asm_group<a name='database::asm_software_asm_group'>

The admin group for ASM.

The default is : `asmadmin`

To customize this consistently use the hiera key `ora_profile::database::asm_software::asm_group`.

Type: `String[1]`


[Back to overview of database::asm_software](#attributes)

### configure_afd<a name='database::asm_software_configure_afd'>

Specify whether or not to configure ASM Filter Driver instead of ASMLib.

The default value is: `false`

To customize this consistently use the hiera key `ora_profile::database::asm_software::configure_afd`.

Type: `Boolean`


[Back to overview of database::asm_software](#attributes)

### grid_type<a name='database::asm_software_grid_type'>

The type of grid.

Valid values are:
- `HA_CONFIG`
- `CRS_CONFIG`
- `HA_SWONLY`   (versions > 11)
- `UPGRADE`
- `CRS_SWONLY`

The default value is: `HA_CONFIG`

To customize this consistently use the hiera key `ora_profile::database::asm_software::grid_type`.

Type: `Enum['CRS_CONFIG','HA_CONFIG','UPGRADE','CRS_SWONLY','HA_SWONLY']`


[Back to overview of database::asm_software](#attributes)

### disk_redundancy<a name='database::asm_software_disk_redundancy'>

The disk redundancy for the initial diskgroup to setup ASM.

Valid values are:

- `EXTENDED`
- `EXTERNAL`
- `FLEX`
- `HIGH`
- `NORMAL`

The default value is: `EXTERNAL`

Type: `Enum['EXTENDED','EXTERNAL','FLEX','HIGH','NORMAL']`


[Back to overview of database::asm_software](#attributes)

### install_task<a name='database::asm_software_install_task'>

The installation task that should be executed.

Type: `Enum['ALL','EXTRACT']`


[Back to overview of database::asm_software](#attributes)

### bash_profile<a name='database::asm_software_bash_profile'>

Whether or not to deploy bash_profile for $os_user or $grid_user

The default is : `true`

Type: `Boolean`


[Back to overview of database::asm_software](#attributes)

### bash_additions<a name='database::asm_software_bash_additions'>

The text to add at the end of the bash_profile. This parameter will only be used when you have specified `true` for the parameter `bash_profile`

The default value is an empty string.

Type: `String`


[Back to overview of database::asm_software](#attributes)

### disks_failgroup_names<a name='database::asm_software_disks_failgroup_names'>

A comma seperated list of device and failure group name.

Valid values are:

- `/dev/sdb,CRSFG1,/dev/sdc,CRSFG2,/dev/sdd,CRSFG3`                                 (NORMAL redundancy)
- `/dev/sdb,,/dev/sdc,,/dev/sdd,,/dev/sde,`                                         (EXTERNAL redundancy)
- `/dev/sdb,CRSFG1,/dev/sdc,CRSFG2,/dev/sdd,CRSFG3,/dev/sde,CRSFG4,/dev/sdf,CRSFG5` (HIGH redundancy)

The default value is: `/nfs_client/asm_sda_nfs_b1,`

Type: `Optional[String[1]]`


[Back to overview of database::asm_software](#attributes)

### cluster_name<a name='database::asm_software_cluster_name'>

The name of the cluster.

The default value is: `undef`

Type: `Optional[String[1]]`


[Back to overview of database::asm_software](#attributes)

### scan_name<a name='database::asm_software_scan_name'>

The hostname to use for the SCAN service.

The default value is: `undef`

Type: `Optional[String[1]]`


[Back to overview of database::asm_software](#attributes)

### scan_port<a name='database::asm_software_scan_port'>

The IP portnumber to use for the SCAN service.

The default value is: `undef`

Type: `Optional[Integer]`


[Back to overview of database::asm_software](#attributes)

### cluster_node_types<a name='database::asm_software_cluster_node_types'>

The names of the nodes in the RAC cluster.

Valid values are:

- `node1:node1-vip,node2:node2-vip`                     (version >= 11 <= 12.1)
- `node1:node1-vip:HUB,node2:node2-vip:LEAF`            (version >= 12.1 Flex Cluster)
- `node1,node2`                                         (version = 12.2 Application Cluster)
- `node1:node1-vip:HUB:site1,node2:node2-vip:HUB:site2` (version = 12.2 Extended Cluster)

The default value is: `undef`

Type: `Optional[String[1]]`


[Back to overview of database::asm_software](#attributes)

### network_interface_list<a name='database::asm_software_network_interface_list'>


The list of interfaces to use for RAC.

The value should be a comma separated strings where each string is as shown below

```
InterfaceName:SubnetAddress:InterfaceType
```

where InterfaceType can be either "1", "2", "3", "4" or "5" (1 indicates public, 2 indicates private, 3 indicates the interface is not used, 4 indicates ASM and 5 indicates ASM & Private)

The default value is: `undef`

Type: `Optional[String[1]]`


[Back to overview of database::asm_software](#attributes)

### storage_option<a name='database::asm_software_storage_option'>

The type of storage to use.

Valid values are:
- `ASM_STORAGE`          (versions = 11)
- `FILE_SYSTEM_STORAGE`  (versions <= 12.1)
- `LOCAL_ASM_STORAGE`    (versions >= 12.1)
- `CLIENT_ASM_STORAGE`   (versions >= 12.2)
- `FLEX_ASM_STORAGE`     (versions >= 12.1)

The default value is: `undef`

Type: `Optional[Enum['FLEX_ASM_STORAGE','CLIENT_ASM_STORAGE','LOCAL_ASM_STORAGE','FILE_SYSTEM_STORAGE','ASM_STORAGE']]`


[Back to overview of database::asm_software](#attributes)
