# Changelog

All notable changes to this project will be documented in this file.

## Release 0.11.0

**New features**

- [db_definition_template] Add log_size parameter
- [db_definition_template] Add -spfile(-p) parameter
- [db_software] Add 19c RAC + remove default logoutput parameter
- [asm_software] Add 19c for RAC
- [db_definition_template] Fill template for 19c
- [db_definition] Manage database on non-master nodes too

**Bug fixes**

- [user_equivalence] Ensure openssh-clients package because we need it
- [core] Add 18c support for RAC
- [db_definition_template] Fix for db_definition_template.pp -> db_control should run as the $os_user
- [core] Rename to 19.0.0.0, oratab entry and setasmgidwrap
- [db_definition] Create init.ora pointer + set cdb in ora_setting
- [afd_label] Required to set ORACLE_BASE in 19c
- [db_definition_template] db_control should run as the $os_user
- [db_definition] Use specified data_file_destination and db_recovery_file_dest in default template
- [user_equivalence] Make better idempotent

## Release 0.10.2

**New features**

- [db_definition] Use disable_corrective_ensure for ora_database

## Release 0.10.1

**Bug fixes**

- [db_definition_template] Fix download_dir
- [db_listener] Fix download_dir

## Release 0.10.0

**New features**

- Add basic windows support

## Release 0.9.1

**Bug fixes**

- [core] Add defaults for download_dir and temp_dir
- [database] export temp_dir
- [db_patches] Export download_dir
- [asm_software] extract download_dir and temp_dir
- [db_software] extract download_dir and temp_dir
- [asm_listener/db_listener] Use the right user and group
- [asm_software] Add defaults for oper_group and ams_group

## Release 0.9.0

**New features**

- Add support for Oracle 19

## Release 0.8.11

**Bug fixes**

- [asm_listener] Call classes with user and group parameters. Closes #26
- [asm_software] Add parameter bash_profile. Closes #23
- [db_software] Add oper_group parameter
- [asm_software] Make OS groups configurable. Closes #19
- [authenticated_nodes] Fix issue when os_user and grid_user are the same. Closes #18
- [db_patches] Fix detection of running database on initial run

## Release 0.8.10

**Bug fixes**

- [db_definition] Fix non container database

## Release 0.8.9

**Bug fixes**

[core] Use ensure_resources in steda of create_resources to make manifests more resilient

## Release 0.8.8

**New features**

- [release] Use correct version of ora_install
- [asm_software] Use new ora_tab_entry type
- [db_definition] Use new ora_tab_entry type

## Release 0.8.7

**New features**

- [db_software] allow usage of bash_profile for db_software
- [db_definition] Fix lint errors
- [docs] reword db_tablespaces::list

## Release 0.8.6

**New features**

-  [db_definition] archivelog configurable
-  [db_definition] add support for RAC
-  [instance] pass log_size and use it

**Bug fixes**

-  [db_definition_template] properly add line to oratab
-  [data] add more defaults
-  [asm_software] properly add line to oratab

## Release 0.8.5

**Bug fixes**

- [db_definition] Container disabled by default

## Release 0.8.4

**New features**

- [db_definition] Add support for container databases

## Release 0.8.3

**Bug fixes**

- [asm_storage] Fix timing issues with ASMlib disks

## Release 0.8.2

**Bug fixes**

- [asm_groups_and_users] Fix used home when not default

## Release 0.8.1

**Bug fixes**

- [asm_software] / [asm_diskgroup] make redundancy configurable
- [docs] update readme with all dependencies

## Release 0.8.0

**New features**

- Add support for Puppet 6

**Bug fixes**

- [quality] Fix rubocop messages
- [core] Update metadata to new pdk

## Release 0.7.1

**Bug fixes**

-  [db_software] Small fixes in ordering and dirs

## Release 0.7.0

**New features**

- Add support for Oracle 18

## Release 0.6.2

**Bugfixes**

- [asm_storage] Remove some NFS defaults and add some afd defaults
- [asm_software] Add extra dir

## Release 0.6.1

**Bugfixes**

- [asm_storage] Some new documentation generated
- [db_software] Use the passed dba_group, install_group and os_user correct

## Release 0.6.0

- [database] Use conditional staged_contain
- [database] Add code for deploying RAC
- [asm] refacter to have easier hiera
- [firewalld] Fix description of rule
- [db_software] Small fix in requires
- [core] Update documentation and some small fixes

## Release 0.5.0

- [core] Add multiple storage options for asm and integrate RAC

## Release 0.4.0

- [database] Fix resource type
- [asm] Fix document generation
- [core] Add code to install ASM
- [spec] Fix unittests when used with latest version of ora_cis
- [db_definition_template] Add docs for db_definition_template manifest
- [firewalld] Use correct zone
- [docs] Add generated docs to some more classes
- [docs] Update source docs
- [db_definition_template] Add code to create database from template

**Features**

- Added initial support for asm 

**Bugfixes**

- Fixed creating oracle users

## Release 0.3.0

- [db_patches] Add support for patching when the database is running
- [db_patches] Apply default patches
- [docs] Update description
- [spec] Remove deprecation messages
- [db_patches] Remove tmp_dir property
- [secured_database] Add initial implementation and docs
- [specs] Move unit specs to correct directory
- [core] Some minor fixes: added required packages for installation and patching (unzip, psmisc) and set the correct patches for a 12.2 release (current patch is April 2018)

**Features**

- Added `ora_profile::secure_database` for having a CIS secured database
- Added support for automatic patches

**Bugfixes**

- Fixed some missing packages

## Release 0.2.0

- [core] Provide better messages on what’s going on.
- [firewall] Remove udp ports list
- [core] Add support for using the customisations without hiera values
- [firewall] Add iptables of firewalld package if not already in catalog
- [db_software] Add zipp to catalog if not already there
- [database] Add support for managing firewall ports.
- [release] Add directly called modules as dependencies & remove unsupported OS-es

**Features**

- Allows management of IP firewall rules for database 
- Allows direct changes of the master parameters through puppet instead of through hiera.
- All directly called modules are now in the metadata

**Bugfixes**

None

**Known Issues**

- Cannot install new patches after the database is already running
- File for Opatch update is not idomatic.

## Release 0.1.0

Initial release

**Features**

- Allows easy database installation and management 

**Bugfixes**

None

**Known Issues**

- Cannot install new patches after the database is already running
- Firewall rules are not added. Just the firewalls are stopped