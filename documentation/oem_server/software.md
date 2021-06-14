---
title: oem server::software
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Installs Oracle Enterprse Manager.




If you want to play and experiment with this type, please take a look at our playgrounds. At our playgrounds, 
we provide you with a pre-installed environment, where you experiment with these Puppet types.

Look at our playgrounds [here](/playgrounds#oracle)

## Attributes



Attribute Name                                                                   | Short Description                                                      |
-------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
[agent_base_dir](#oem_server::software_agent_base_dir)                           | The directory to use as base for the agent software.                   |
[agent_registration_password](#oem_server::software_agent_registration_password) | The password to use to register the agent.                             |
[database_hostname](#oem_server::software_database_hostname)                     | The DNS name of the database host.                                     |
[database_listener_port](#oem_server::software_database_listener_port)           | The IP port for the database listener.                                 |
[database_service_sid_name](#oem_server::software_database_service_sid_name)     | The database service SID name for the database.                        |
[database_sys_password](#oem_server::software_database_sys_password)             | The password of the SYS user of the database.                          |
[deployment_size](#oem_server::software_deployment_size)                         | The size of the deployment.                                            |
[download_dir](#oem_server::software_download_dir)                               | The directory where the Puppet software puts all downloaded files.     |
[file](#oem_server::software_file)                                               | The source file to use.                                                |
[group](#oem_server::software_group)                                             | The dba group for ASM.                                                 |
[logoutput](#oem_server::software_logoutput)                                     | log the outputs of Puppet exec or not.                                 |
[ora_inventory_dir](#oem_server::software_ora_inventory_dir)                     | The directory that contains the oracle inventory.                      |
[oracle_base_dir](#oem_server::software_oracle_base_dir)                         | A directory to use as Oracle base directory.                           |
[oracle_home_dir](#oem_server::software_oracle_home_dir)                         | A directory to be used as Oracle home directory for this software.     |
[puppet_download_mnt_point](#oem_server::software_puppet_download_mnt_point)     | Where to get the source of your template from.                         |
[software_library_dir](#oem_server::software_software_library_dir)               | The directory to use for the software library.                         |
[swonly](#oem_server::software_swonly)                                           | Only install the software without configuration (true) or not (false). |
[sysman_password](#oem_server::software_sysman_password)                         | The password to use for sysman.                                        |
[temp_dir](#oem_server::software_temp_dir)                                       | Directory to use for temporary files.                                  |
[user](#oem_server::software_user)                                               | The user used for the specified installation.                          |
[version](#oem_server::software_version)                                         | The server version to be installed
                                    |
[weblogic_password](#oem_server::software_weblogic_password)                     | The password to use for WebLogic.                                      |
[weblogic_user](#oem_server::software_weblogic_user)                             | The username to use for WebLogic.                                      |
[zip_extract](#oem_server::software_zip_extract)                                 | The specified source file is a zip file that needs te be extracted.    |




### agent_base_dir<a name='oem_server::software_agent_base_dir'>

The directory to use as base for the agent software.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_server::software](#attributes)

### agent_registration_password<a name='oem_server::software_agent_registration_password'>

The password to use to register the agent.

Type: `Easy_type::Password`


[Back to overview of oem_server::software](#attributes)

### database_hostname<a name='oem_server::software_database_hostname'>

The DNS name of the database host.

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### database_listener_port<a name='oem_server::software_database_listener_port'>

The IP port for the database listener.

The default value is: `1521`

Type: `Integer`


[Back to overview of oem_server::software](#attributes)

### database_service_sid_name<a name='oem_server::software_database_service_sid_name'>

The database service SID name for the database.

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### database_sys_password<a name='oem_server::software_database_sys_password'>

The password of the SYS user of the database.

Type: `Easy_type::Password`


[Back to overview of oem_server::software](#attributes)

### deployment_size<a name='oem_server::software_deployment_size'>

The size of the deployment.

Valid values are:
- `SMALL`
- `MEDIUM`
- `LARGE`

The default value is: `SMALL`

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### download_dir<a name='oem_server::software_download_dir'>

The directory where the Puppet software puts all downloaded files.

Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.

The default value is: `/install`

To customize this consistently use the hiera key `ora_profile::database::download_dir`.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_server::software](#attributes)

### file<a name='oem_server::software_file'>

The source file to use.

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### group<a name='oem_server::software_group'>

The dba group for ASM.

The default is : `asmdba`

To customize this consistently use the hiera key `ora_profile::database::asm_software::group`.

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### logoutput<a name='oem_server::software_logoutput'>

log the outputs of Puppet exec or not.

When you specify `true` Puppet will log all output of `exec` types.

Valid values are:

- `true`
- `false`
- `on_failure`

Type: `Variant[Boolean,Enum['on_failure']]`


[Back to overview of oem_server::software](#attributes)

### ora_inventory_dir<a name='oem_server::software_ora_inventory_dir'>

The directory that contains the oracle inventory.

The default value is: `/oracle_base/oraInventory`

To customize this consistently use the hiera key `ora_profile::database::ora_inventory_dir`.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_server::software](#attributes)

### oracle_base_dir<a name='oem_server::software_oracle_base_dir'>

A directory to use as Oracle base directory.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_server::software](#attributes)

### oracle_home_dir<a name='oem_server::software_oracle_home_dir'>

A directory to be used as Oracle home directory for this software.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_server::software](#attributes)

### puppet_download_mnt_point<a name='oem_server::software_puppet_download_mnt_point'>

Where to get the source of your template from. This is the module where the xml file for your template is stored as a puppet template(erb).

The default value is `ora_profile`
Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### software_library_dir<a name='oem_server::software_software_library_dir'>

The directory to use for the software library.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_server::software](#attributes)

### swonly<a name='oem_server::software_swonly'>

Only install the software without configuration (true) or not (false).

The default value is: `false`

Type: `Boolean`


[Back to overview of oem_server::software](#attributes)

### sysman_password<a name='oem_server::software_sysman_password'>

The password to use for sysman.

Type: `Easy_type::Password`


[Back to overview of oem_server::software](#attributes)

### temp_dir<a name='oem_server::software_temp_dir'>

Directory to use for temporary files.

Type: `Stdlib::Absolutepath`


[Back to overview of oem_server::software](#attributes)

### user<a name='oem_server::software_user'>

The user used for the specified installation.
The install class will not create the user for you. You must do that yourself.

The default value is: `oracle`

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### version<a name='oem_server::software_version'>

The server version to be installed

- `12.1.0.4`
- `12.1.0.5`
- `13.1.0.0`
- `13.2.0.0`
- `13.3.0.0`
- `13.4.0.0`
- `13.5.0.0`

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### weblogic_password<a name='oem_server::software_weblogic_password'>

The password to use for WebLogic.

Type: `Easy_type::Password`


[Back to overview of oem_server::software](#attributes)

### weblogic_user<a name='oem_server::software_weblogic_user'>

The username to use for WebLogic.

The default value is: `weblogic`

Type: `String[1]`


[Back to overview of oem_server::software](#attributes)

### zip_extract<a name='oem_server::software_zip_extract'>

The specified source file is a zip file that needs te be extracted.
When you specify a value of false, the source attribute must contain a reference to a directory instead of a zip file.

The default value is: `true`

Type: `Boolean`


[Back to overview of oem_server::software](#attributes)
