---
title: oem server::server
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Installs Oracle Enterprse Manager.




## Attributes



Attribute Name                                                                 | Short Description                                                   |
------------------------------------------------------------------------------ | ------------------------------------------------------------------- |
[agent_base_dir](#oem_server::server_agent_base_dir)                           | The directory to use as base for the agent software.                |
[agent_registration_password](#oem_server::server_agent_registration_password) | The password to use to register the agent.                          |
[database_hostname](#oem_server::server_database_hostname)                     | The DNS name of the database host.                                  |
[database_listener_port](#oem_server::server_database_listener_port)           | The IP port for the database listener.                              |
[database_service_sid_name](#oem_server::server_database_service_sid_name)     | The database service SID name for the database.                     |
[database_sys_password](#oem_server::server_database_sys_password)             | The password of the SYS user of the database.                       |
[deployment_size](#oem_server::server_deployment_size)                         | The size of the deployment.                                         |
[download_dir](#oem_server::server_download_dir)                               | The directory where the Puppet software puts all downloaded files.  |
[file](#oem_server::server_file)                                               | The source file to use.                                             |
[group](#oem_server::server_group)                                             | The dba group for ASM.                                              |
[logoutput](#oem_server::server_logoutput)                                     | log the outputs of Puppet exec or not.                              |
[ora_inventory_dir](#oem_server::server_ora_inventory_dir)                     | The directory that contains the oracle inventory.                   |
[oracle_base_dir](#oem_server::server_oracle_base_dir)                         | A directory to use as Oracle base directory.                        |
[oracle_home_dir](#oem_server::server_oracle_home_dir)                         | A directory to be used as Oracle home directory for this software.  |
[puppet_download_mnt_point](#oem_server::server_puppet_download_mnt_point)     | Where to get the source of your template from.                      |
[software_library_dir](#oem_server::server_software_library_dir)               | The directory to use for the software library.                      |
[sysman_password](#oem_server::server_sysman_password)                         | The password to use for sysman.                                     |
[temp_dir](#oem_server::server_temp_dir)                                       | Directory to use for temporary files.                               |
[user](#oem_server::server_user)                                               | The user used for the specified installation.                       |
[version](#oem_server::server_version)                                         | The version of Oracle you want to install.                          |
[weblogic_password](#oem_server::server_weblogic_password)                     | The password to use for WebLogic.                                   |
[weblogic_user](#oem_server::server_weblogic_user)                             | The username to use for WebLogic.                                   |
[zip_extract](#oem_server::server_zip_extract)                                 | The specified source file is a zip file that needs te be extracted. |




### agent_base_dir<a name='oem_server::server_agent_base_dir'>

The directory to use as base for the agent software.


[Back to overview of oem_server::server](#attributes)

### agent_registration_password<a name='oem_server::server_agent_registration_password'>

The password to use to register the agent.


[Back to overview of oem_server::server](#attributes)

### database_hostname<a name='oem_server::server_database_hostname'>

The DNS name of the database host.


[Back to overview of oem_server::server](#attributes)

### database_listener_port<a name='oem_server::server_database_listener_port'>

The IP port for the database listener.

The default value is: `1521`


[Back to overview of oem_server::server](#attributes)

### database_service_sid_name<a name='oem_server::server_database_service_sid_name'>

The database service SID name for the database.


[Back to overview of oem_server::server](#attributes)

### database_sys_password<a name='oem_server::server_database_sys_password'>

The password of the SYS user of the database.


[Back to overview of oem_server::server](#attributes)

### deployment_size<a name='oem_server::server_deployment_size'>

The size of the deployment.

Valid values are:
- `SMALL`
- `MEDIUM`
- `LARGE`

The default value is: `SMALL`


[Back to overview of oem_server::server](#attributes)

### download_dir<a name='oem_server::server_download_dir'>

The directory where the Puppet software puts all downloaded files.

Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.

The default value is: `/install`


[Back to overview of oem_server::server](#attributes)

### file<a name='oem_server::server_file'>

The source file to use.


[Back to overview of oem_server::server](#attributes)

### group<a name='oem_server::server_group'>

The dba group for ASM.

The default is : `asmdba`

To customize this consistently use the hiera key `ora_profile::database::asm_software::group`.


[Back to overview of oem_server::server](#attributes)

### logoutput<a name='oem_server::server_logoutput'>

log the outputs of Puppet exec or not.

When you specify `true` Puppet will log all output of `exec` types.

Valid values are:

- `true`
- `false`
- `on_failure`


[Back to overview of oem_server::server](#attributes)

### ora_inventory_dir<a name='oem_server::server_ora_inventory_dir'>

The directory that contains the oracle inventory.

The default value is: `/oracle_base/oraInventory`


[Back to overview of oem_server::server](#attributes)

### oracle_base_dir<a name='oem_server::server_oracle_base_dir'>

A directory to use as Oracle base directory.


[Back to overview of oem_server::server](#attributes)

### oracle_home_dir<a name='oem_server::server_oracle_home_dir'>

A directory to be used as Oracle home directory for this software.


[Back to overview of oem_server::server](#attributes)

### puppet_download_mnt_point<a name='oem_server::server_puppet_download_mnt_point'>

Where to get the source of your template from. This is the module where the xml file for your template is stored as a puppet template(erb).

The default value is `ora_profile`

[Back to overview of oem_server::server](#attributes)

### software_library_dir<a name='oem_server::server_software_library_dir'>

The directory to use for the software library.


[Back to overview of oem_server::server](#attributes)

### sysman_password<a name='oem_server::server_sysman_password'>

The password to use for sysman.


[Back to overview of oem_server::server](#attributes)

### temp_dir<a name='oem_server::server_temp_dir'>

Directory to use for temporary files.


[Back to overview of oem_server::server](#attributes)

### user<a name='oem_server::server_user'>

The user used for the specified installation.
The install class will not create the user for you. You must do that yourself.

The default value is: `oracle`


[Back to overview of oem_server::server](#attributes)

### version<a name='oem_server::server_version'>

The version of Oracle you want to install.

The default is : `12.2.0.1`

To customize this consistently use the hiera key `ora_profile::database::version`.


[Back to overview of oem_server::server](#attributes)

### weblogic_password<a name='oem_server::server_weblogic_password'>

The password to use for WebLogic.


[Back to overview of oem_server::server](#attributes)

### weblogic_user<a name='oem_server::server_weblogic_user'>

The username to use for WebLogic.

The default value is: `weblogic`


[Back to overview of oem_server::server](#attributes)

### zip_extract<a name='oem_server::server_zip_extract'>

The specified source file is a zip file that needs te be extracted.
When you specify a value of false, the source attribute must contain a reference to a directory instead of a zip file.

The default value is: `true`


[Back to overview of oem_server::server](#attributes)
