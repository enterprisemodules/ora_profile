---
title: database::common
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains common variables used by more then one class.






## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                                 | Short Description                                                                                                 |
-------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
[cluster_nodes](#database::common_cluster_nodes)               | An array with cluster node names for RAC.                                                                         |
[db_control_provider](#database::common_db_control_provider)   | Which provider should be used for the type db_control.                                                            |
[download_dir](#database::common_download_dir)                 | The directory where the Puppet software puts all downloaded files.                                                |
[grid_base](#database::common_grid_base)                       | The ORACLE_BASE for the Grid Infrastructure installation.                                                         |
[grid_home](#database::common_grid_home)                       | The ORACLE_HOME for the Grid Infrastructure installation.                                                         |
[grid_user](#database::common_grid_user)                       | The name of the user that owns the Grid Infrastructure installation.                                              |
[install_group](#database::common_install_group)               | The group to use for Oracle install.                                                                              |
[master_node](#database::common_master_node)                   | The first node in RAC.                                                                                            |
[ora_inventory_dir](#database::common_ora_inventory_dir)       | The directory that contains the oracle inventory.                                                                 |
[oracle_user_password](#database::common_oracle_user_password) | The password for the oracle os user.                                                                              |
[patch_levels](#database::common_patch_levels)                 | Defines all the patch levels for both database and grid infrastructure formost common versions 12.2, 18c and 19c. |
[patch_window](#database::common_patch_window)                 | The patch window in which you want to do the patching.                                                            |
[source](#database::common_source)                             | The location where the classes can find the software.                                                             |
[temp_dir](#database::common_temp_dir)                         | Directory to use for temporary files.                                                                             |
[version](#database::common_version)                           | The version of Oracle you want to install.                                                                        |




### version<a name='database::common_version'>

The version of Oracle you want to install.

The default is : `12.2.0.1`

To customize this consistently use the hiera key `ora_profile::database::version`.

Type: `Any`

Default:`lookup('ora_profile::database::version', Ora_Install::Version)`

[Back to overview of database::common](#attributes)

### download_dir<a name='database::common_download_dir'>

The directory where the Puppet software puts all downloaded files.

Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.

The default value is: `/install`

To customize this consistently use the hiera key `ora_profile::database::download_dir`.

Type: `Any`

Default:`lookup('ora_profile::database::download_dir', String[1])`

[Back to overview of database::common](#attributes)

### install_group<a name='database::common_install_group'>

The group to use for Oracle install.

The default is : `oinstall`

To customize this consistently use the hiera key `ora_profile::database::install_group`.

Type: `Any`

Default:`lookup('ora_profile::database::install_group', String[1])`

[Back to overview of database::common](#attributes)

### master_node<a name='database::common_master_node'>

The first node in RAC.
This  is the node where the other nodes will clone the software installations from.

To customize this consistently use the hiera key `ora_profile::database::master_node`.

Type: `Any`

Default:`lookup('ora_profile::database::master_node', Optional[String[1]], undef, $facts['networking']['hostname'])`

[Back to overview of database::common](#attributes)

### ora_inventory_dir<a name='database::common_ora_inventory_dir'>

The directory that contains the oracle inventory.

The default value is: `/oracle_base/oraInventory`

To customize this consistently use the hiera key `ora_profile::database::ora_inventory_dir`.

Type: `Any`

Default:`lookup('ora_profile::database::ora_inventory_dir', String[1])`

[Back to overview of database::common](#attributes)

### grid_home<a name='database::common_grid_home'>

The ORACLE_HOME for the Grid Infrastructure installation.

The default is : `/u01/app/grid/product/12.2.0.1/grid_home1`

To customize this consistently use the hiera key `ora_profile::database::grid_home`.

Type: `Any`

Default:`lookup('ora_profile::database::grid_home', String[1])`

[Back to overview of database::common](#attributes)

### grid_base<a name='database::common_grid_base'>

The ORACLE_BASE for the Grid Infrastructure installation.

The default is : `/u01/app/grid/admin`

To customize this consistently use the hiera key `ora_profile::database::grid_base`.

Type: `Any`

Default:`lookup('ora_profile::database::grid_base', String[1])`

[Back to overview of database::common](#attributes)

### grid_user<a name='database::common_grid_user'>

The name of the user that owns the Grid Infrastructure installation.

The default value is: `grid`.
Type: `Any`

Default:`lookup('ora_profile::database::grid_user', String[1])`

[Back to overview of database::common](#attributes)

### temp_dir<a name='database::common_temp_dir'>

Directory to use for temporary files.

Type: `Any`

Default:`lookup('ora_profile::database::temp_dir', String[1])`

[Back to overview of database::common](#attributes)

### source<a name='database::common_source'>

The location where the classes can find the software. 

You can specify a local directory, a Puppet url or an http url.

The default is : `puppet:///modules/software/`

To customize this consistently use the hiera key `ora_profile::database::source`.

Type: `Any`

Default:`lookup('ora_profile::database::source', String[1])`

[Back to overview of database::common](#attributes)

### cluster_nodes<a name='database::common_cluster_nodes'>

An array with cluster node names for RAC.

Example:
```yaml
ora_profile::database::cluster_nodes:
- node1
- node2
```

Type: `Any`

Default:`lookup('ora_profile::database::cluster_nodes', Optional[Array])`

[Back to overview of database::common](#attributes)

### oracle_user_password<a name='database::common_oracle_user_password'>

The password for the oracle os user.
Only applicable for Windows systems.

To customize this consistently use the hiera key `ora_profile::database::oracle_user_password`.

Type: `Any`

Default:`lookup('ora_profile::database::oracle_user_password', Optional[String[1]], undef, undef)`

[Back to overview of database::common](#attributes)

### db_control_provider<a name='database::common_db_control_provider'>

Which provider should be used for the type db_control.

The default value is: `sqlplus`

To customize this consistently use the hiera key `ora_profile::database::db_control_provider`.

Type: `Any`

Default:`lookup('ora_profile::database::db_control_provider', Optional[String[1]])`

[Back to overview of database::common](#attributes)

### patch_window<a name='database::common_patch_window'>

The patch window in which you want to do the patching. Every time puppet runs outside of this patcn windows, puppet will detect the patches are not installed, but puppet will not shutdown the database and apply the patches.

an example on how to use this is:

        patch_window => '2:00 - 4:00'

Type: `Any`

Default:`lookup('ora_profile::database::patch_window', Optional[String[1]])`

[Back to overview of database::common](#attributes)

### patch_levels<a name='database::common_patch_levels'>

Defines all the patch levels for both database and grid infrastructure formost common versions 12.2, 18c and 19c.
The default values look like the example below.
In addition to all the parameters for ora_opatch, except sub_patches and source, (see [ora_opatch]https://www.enterprisemodules.com/docs/ora_install/ora_opatch.html) the following parameters can be specified:

        db_sub_patches: Array of sub patches applicable for database installations
        grid_sub_patches: Array of sub patches applicable for grid infrastructure installations
        file: zipfile that contains the patch
        type: 'one-off' or 'psu'

an example on how to use this is:

```yaml
ora_profile::database::patch_levels:
  '19.0.0.0':
    OCT2020RU:
      "31750108-GIRU-19.9.0.0.201020":
        file:                  "p31750108_190000_Linux-x86-64.zip"
        db_sub_patches:        ['31771877','31772784']
        grid_sub_patches:      ['31771877','31772784','31773437','31780966']

```

Type: `Any`

Default:`lookup('ora_profile::database::patch_levels', Hash)`

[Back to overview of database::common](#attributes)
