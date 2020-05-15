---
title: oem agent::software
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Installs Oracle Enterprse Manager Agent.




## Attributes



Attribute Name                                                                  | Short Description                                                  |
------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
[agent_base_dir](#oem_agent::software_agent_base_dir)                           | The directory to use as instance home.                             |
[agent_registration_password](#oem_agent::software_agent_registration_password) | The password to use to register the agent.                         |
[download_dir](#oem_agent::software_download_dir)                               | The directory where the Puppet software puts all downloaded files. |
[em_upload_port](#oem_agent::software_em_upload_port)                           | The port number of the HTTP port for the upload service.           |
[install_agent](#oem_agent::software_install_agent)                             | Flag to indicate the OEM Agent needs to be installed or not.       |
[install_group](#oem_agent::software_install_group)                             | The group to use for Oracle install.                               |
[install_version](#oem_agent::software_install_version)                         | The version you want to install.                                   |
[oms_host](#oem_agent::software_oms_host)                                       | The OMS host to use.                                               |
[oms_port](#oem_agent::software_oms_port)                                       | The IP port to use for connecting to the OMS host.                 |
[ora_inventory_dir](#oem_agent::software_ora_inventory_dir)                     | The directory that contains the oracle inventory.                  |
[oracle_base](#oem_agent::software_oracle_base)                                 | The base directory to use for the Oracle installation.             |
[os_user](#oem_agent::software_os_user)                                         | The OS user to use for Oracle install.                             |
[sysman_password](#oem_agent::software_sysman_password)                         | The password to use for sysman.                                    |
[sysman_user](#oem_agent::software_sysman_user)                                 | The sysman user.                                                   |
[temp_dir](#oem_agent::software_temp_dir)                                       | Directory to use for temporary files.                              |
[version](#oem_agent::software_version)                                         | The agent version to be installed
                                 |




### agent_base_dir<a name='oem_agent::software_agent_base_dir'>

The directory to use as instance home.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_agent::software](#attributes)

### agent_registration_password<a name='oem_agent::software_agent_registration_password'>

The password to use to register the agent.

Type: `Easy_type::Password`


[Back to overview of oem_agent::software](#attributes)

### download_dir<a name='oem_agent::software_download_dir'>

The directory where the Puppet software puts all downloaded files.

Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.

The default value is: `/install`

Type: `Stdlib::Absolutepath`


[Back to overview of oem_agent::software](#attributes)

### em_upload_port<a name='oem_agent::software_em_upload_port'>

The port number of the HTTP port for the upload service.

The default value is: `1159`

Type: `Integer`


[Back to overview of oem_agent::software](#attributes)

### install_agent<a name='oem_agent::software_install_agent'>

Flag to indicate the OEM Agent needs to be installed or not.
In case your OEM Server hasn't been installed yet, set this to `false`

Type: `Boolean`

Default:`true`

[Back to overview of oem_agent::software](#attributes)

### install_group<a name='oem_agent::software_install_group'>

The group to use for Oracle install.

The default is : `oinstall`

To customize this consistently use the hiera key `ora_profile::database::install_group`.

Type: `String`


[Back to overview of oem_agent::software](#attributes)

### install_version<a name='oem_agent::software_install_version'>

The version you want to install.

The default value is: `12.1.0.5.0`

Type: `String`


[Back to overview of oem_agent::software](#attributes)

### oms_host<a name='oem_agent::software_oms_host'>

The OMS host to use.

Type: `String`


[Back to overview of oem_agent::software](#attributes)

### oms_port<a name='oem_agent::software_oms_port'>

The IP port to use for connecting to the OMS host.

Type: `Integer`


[Back to overview of oem_agent::software](#attributes)

### ora_inventory_dir<a name='oem_agent::software_ora_inventory_dir'>

The directory that contains the oracle inventory.

The default value is: `/oracle_base/oraInventory`

Type: `Stdlib::Absolutepath`


[Back to overview of oem_agent::software](#attributes)

### oracle_base<a name='oem_agent::software_oracle_base'>

The base directory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of oem_agent::software](#attributes)

### os_user<a name='oem_agent::software_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String`


[Back to overview of oem_agent::software](#attributes)

### sysman_password<a name='oem_agent::software_sysman_password'>

The password to use for sysman.

Type: `Easy_type::Password`


[Back to overview of oem_agent::software](#attributes)

### sysman_user<a name='oem_agent::software_sysman_user'>

The sysman user.

The default value is: `sysman`

Type: `String`


[Back to overview of oem_agent::software](#attributes)

### temp_dir<a name='oem_agent::software_temp_dir'>

Directory to use for temporary files.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_agent::software](#attributes)

### version<a name='oem_agent::software_version'>

The agent version to be installed

- `12.1.0.4`
- `12.1.0.5`
- `13.1.0.0`
- `13.2.0.0`
- `13.3.0.0`

Type: `String`


[Back to overview of oem_agent::software](#attributes)
