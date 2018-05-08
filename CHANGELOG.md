# Changelog

All notable changes to this project will be documented in this file.

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