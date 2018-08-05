# Changelog


All notable changes to this project will be documented in this file.

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