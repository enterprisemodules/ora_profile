# Changelog

All notable changes to this project will be documented in this file.

## Release 0.47.0

**Bug fixes**

- [db_software] Set correct mode when creating the download_dir
- [db_patches] Fix wrongly defined JAN2024RU hieradata for Windows

**new features**

- [release] Add support for EL 9 releases and update dependencies

## Release 0.46.1

**Bug fixes**

- [db_patches] Bugfixes for Windows

## Release 0.46.0

**new features**

- [patches] Add patchlevels for Linux, Solaris and Windows
- [release] Update dependencies
- [core] Add better support for Windows

## Release 0.45.0

**new features**

- [asm_patches, db_patches] Add support for multi levels patching
- [db_definition] Add 'options' parameter

**Maintenance fixes**

- [release] Update dependencies

## Release 0.44.4

**Bug fixes**

- [db_patches] added apr2023 patch for 19c (#143)
- [release] Update dependecies for augueas_core and augeas_grub
- [client] Fix packages for client on Redhat 8

## Release 0.44.3

**Bug fixes**

- [release] Update dependecies for augueas_core and augeas_grub
- [client] Fix packages for client on Redhat 8

## Release 0.44.2

**Bug fixes**

- [set_param] Fix unknown variable on Puppet 8

## Release 0.44.1

**Bug fixes**

- [release] Update version info of some dependencies
- [core] Replace deprecated has_key functions

## Release 0.44.0

**new features**

- [core] Added support for Puppet 8 and Ruby 3

## Release 0.43.0

- [release] Fix dependencies
- [db_definition] Pull oracle_base parameter into init_params
- [asm_patches/db_patches] Add JAN2023RU
- [asm_patches/db_patches] Add check for required OPatch version [sc-1202]

## Release 0.42.2

**Bug fixes**

- [data] Fix lookups for specific versions

## Release 0.42.1

**Bug fixes**

[core] Implement oracle version hiera lookup based on additional key (#139) and move data to appropriate version file.

## Release 0.42.0

**New Features**

- [asm_patches/db_patches] Add October 2022 PSU (#136)

**Bug fixes**

- [core] Set Oracle 19c as default (#138)
- [release] Update dependencies
- [asm_patches] Use different tmp_dir for asm patches then for db_patches (#134)


## Release 0.41.1

**Bug fixes**

- [core] Update to use latest version of versioned_data hiera backend
## Release 0.41.0

**New Features**

- [core] Use latest version of versioned_data hiera backend

## Release 0.40.0

**New Features**

- [autostartdatabase] Implement custom template for systemd service (#135)
- [db_monitoring] Initial implementation with OSWatcher

## Release 0.39.0

**New Features**

- [common] Make common settings puppet adjustable

## Release 0.38.0

**New Features**

- [patches] Add JUL2022 PSU

## Release 0.37.0

**Bug fixes**

- [em_license] Fix for using EM profile classed together
## Release 0.36.0

**New Features**

- [db_startup] Pass limits to db_startup class

## Release 0.35.1

**Bug fixes**

- [db_software] Add sane default for user_base_dir

## Release 0.35.0

**New Features**

- [db_software] Allow access to ora_install::installdb user_base_dir
- [data] Add April 2022 PSU

## Release 0.34.0

**Bug fixes**

- [core] Fix asm support on EL8 systems
- [em_license] Use license::activate instead of license::available

**New Features**

- [release] Add support for AlmaLinux and Rocky

## Release 0.33.0


**Bug fixes**

- [db_definition_template] Add a sane for default init_params
- [db_definition_template] Add init_params parameter and enable acceptance tests
- [add_node] Add umask and remove gimr variables from templates

**New Features**

- [core] Implement fact caching
- [asm/db_patches] Add JAN2022 PSU (#123)
- [asm_patches/db_patches] Add support for OCT2021 patch levels (#120)
- [db_patches] Exclude Oracle 21c from installing OJVM patches,they are included in RU/RUR

## Release 0.32.0

**Bug fixes**

- [db_patches] Apply opatchupdate to ALL homes in the catalog

**New Features**

- [db_patches] Use open_mode to determine if datapatch and utlrp should run
- [asm_patches/db_patches] Add support for July 2021 PSU for 12.2 and 19 (#115)

## Release 0.31.0

**New Features**

[core] Add support for Oracle 21c

## Release 0.30.1

**Bug fixes**

- [docs] Better description of the type of hashes to pass
- [docs] Add Super powers link to playgrounds
- [asm_patches/db_patches] Handle patch level NONE better and still catch missing levels

## Release 0.30.0

**New Features**

- [asm_storage] Add storage_type none

## Release 0.29.0

**New Features**

- [oem_server/oem_agent] Add support for 13.4 and 13.5
- [db_patches] Added patch_level NONE to all versions

## Release 0.28.0


**New Features**

- [cis_controls] Update to use ora_secured
- [db_definition] Enable dropping a database, set to ensure = absent
- [asm_patches/db_patches] Add April 2021 patch level
- [asm_patches] Support patching running system with Oracle Restart and RAC

**Bug fixes**

- [ora_profile] Small bug fixes
- [db_patches] Fail when an undefined patchlevel is used


## Release 0.27.0

**New Features**

- [release] Add playground link to README
- [disable_thp] Added functionality
- [db_patches] Add JAN2021RU patch levels

**Bug fixes**

- [oem_server] Manage ora_autotask properly and lower password complexity for sysman
- [groups_and_users] Leave hashing of passwords to class
- [groups_and_users] Make sure the os passwords are specified

## Release 0.26.0

**New Features**

- [common] Add db_control_provider
- [db_patches] Add OCT2020 patch levels
- [db_patches] Stop/Start all running listeners based on fact
- [release] Add support for puppet 7 in metadata

## Release 0.25.0

**New Features**

- [extracted_database] Add required parameters to class
- [core] Add support for oracle version specific yaml data
- [extracted_database] Add initial implementation
- [core] ora_install puppet functions occurances replaced to the newer version

**Bug fixes**

- [db_patches] Ensure datapatch and UTLRP when TWO_TASK is set

## Release 0.24.2

**Bug fixes**

- [db_patches] Fix issue when adding new oracle_home to running system

## Release 0.24.1

**Bug fixes**

- [oem_agent] provide a sane default for tmp_dir
- [oem_agent] Fix call to staged_contain
- [oem_server] Fix call to staged_contain

## Release 0.24.0

**New Features**

- [core] Add easy_type::debug_evaluation to all classes
- [core] Migrate from staged_contain to use ordered_steps
- [core] Unzip package added to the required packages.
- [core] Convert erb templates to epp

## Release 0.23.0

**New Features**

- [oem] Add OEM server and agent to ora_profile

## Release 0.22.0

**New Features**

- [dba_patches] Add July 2020 Release Updates for version 12.2, 18 and 19
- [tmpfiles] Control rhel tmpfiles systemd service


## Release 0.21.0

**New Features**

- [db_patches] Add JUL2020RU patchlevel

## Release 0.20.1

**Bug fixes**

- [db_definition_template] Make domain optional

## Release 0.20.0

**New Features**

- [core] Add Redhat-7 hiera layer with packages
- [core] Remove all 32-bits packages

## Release 0.19.1

**Bug fixes**

- [db_definition] Make dbdomain optional
- [db_definition] Fix non-master_node usecase
- [db_patches] Move opatchupgrade outside of loop and apply to all
- [db_patches] Remove condition for opatchupgrade

## Release 0.19.0

**New Features**

- [db_patches] Better handle stopping and starting databases and listeners [ch352]
- [db_definition] Add support for multiple databases [ch353]
- [db_listener] Add support for multiple listeners [ch370]


## Release 0.18.1

**Bug fixes**

- [db_patches] Fix patch_window
- [core] Consistently use logoutput in asm_patches, db_patches and db_defintion_* classes

## Release 0.18.0

**New Features**

- [db_software] Enable installation of multiple ORACLE_HOME's
- [db_patches] Add patch levels
- [db_definition_template] Expose dbdomain and add docs
- [db_definition]DB domain is now configurable and diagnostic_dest uses always value from oracle_base parameter

**Bug fixes**

- [data] Add the X11 packages
- [documentation] Update docs and add REFERENCE.md
- [defaults] Removed db_init_params
- [asm_patches] Fix usecase where PSU has only one sub patch with same number
- [asm_storage] Fix for udev rules when more then 26 disk devices are present
- [asm_software] Use gridSetup.sh for version 18 and 19
- [db_definition] Fix default value for dbdomain

## Release 0.17.2

- [asm_groups_and_users] Allow standalone usage
- [firewalld] Log dropped packets differently

## Release 0.17.1

- [core] Fix support for RHEL8 and OracleLinux8 type OS-es

## Release 0.17.0

**New Features**

- [db_software] Add support for bash_additions
- [asm_software] Add support for bash_additions

## Release 0.16.0

**New Features**

- [client] Added first implementation

## Release 0.15.1

**Bug fixes**

- [em_license] Fix detection of previous invocation

## Release 0.15.0

**New Features**

- [core] Add em_license as first stage

## Release 0.14.3

**Bug fixes**

- [db_patches] Fix ‘Unknown variable’ warning
- [asm_setup] Fix usage of sys_asm_password
- [asm_software] Fix usage of sys_asm_password

## Release 0.14.2

**Bug fixes**

- [core] Add asm_sys_password to list of generated passwords
- [release] Update dependencies

## Release 0.14.1

**Bug fixes**

- [db_definition_template] Fix sys_password and add system_password

## Release 0.14.0

**New Features**

- [core] Make password sensitive
- [core] Use generated passwords
- [database] Don’t apply db_startup when we detect RAC

## Release 0.13.5

**Bug fixes**

- [db_definition] Fix settings on second node

## Release 0.13.4

**Bug fixes**

- [user_equivalence] Make installation of openssh more resilient

## Release 0.13.3

**Bug fixes**

- [asm_patches] Improve ASM patching mechanism
- [asm_patches] Use empty value for ora_profile::database::db_patches::patch_list as default

## Release 0.13.2

**Bug fixes**

- [asm_setup] Use alias iso lookup
- [asm_patches/asm_setup] Set defaults
- [asm_patches] Fix case statement
- [user_equivalence] Fix typo
- [asm_patches] Generate a script to do the patching

## Release 0.13.1

**Bug fixes**

- [asm_patches] Fix issue when no sub_patches defined

## Release 0.13.0

**New features**

- [release] Add support for RHEL 8 os-es
- [asm_patches] Add manifests for applying patches in ASM

## Release 0.12.0

**New features**

- [db_definition] Allow ora_database settings override in detail
- [init_params] Manage init params for ASM and DB

**Bug fixes**

- [db_definition_template] Fix Oracle 19 template
- [secured_database] Refacter code for less change on circular dep
- [db_software] change dependency on unzip package to be moree resilient


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