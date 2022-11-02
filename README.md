
[![Enterprise Modules](https://raw.githubusercontent.com/enterprisemodules/public_images/master/banner1.jpg)](https://www.enterprisemodules.com)

#### Table of Contents

1. [Overview](#overview)
2. [Experience the Power of Puppet for Oracle databases](#experience-the-power-of-puppet-for-oracle-databases)
3. [License](#license)
4. [Description - What the module does and why it is useful](#description)
5. [Setup](#setup)
  * [Requirements](#requirements)
  * [Installing the ora_profile module](#installing-the-ora_profile-module)
6. [Usage - Configuration options and additional functionality](#usage)
7. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
8. [Limitations - OS compatibility, etc.](#limitations)

## Overview

The `ora_profile` module allows an easy path from first simple installation to a fully customized Enterprise setup. It is part of our family of Puppet modules to install, manage and secure Oracle databases with Puppet. Besides the `ora_profile` module, this family also contains:

- [ora_install](https://www.enterprisemodules.com/shop/products/puppet-ora_install-module) For installing an Oracle database and other database related Oracle products
- [ora_config](https://www.enterprisemodules.com/shop/products/puppet-ora_config-module) For configuring every aspect of your Oracle database
- [ora_secured](https://www.enterprisemodules.com/shop/products/puppet-oracle-security-module) To secure your databases according to the CIS benchmarks or STIG documents.

This module support Oracle 10, 11, 12, 18, 19 and 21

## Experience the Power of Puppet for Oracle databases

Managing the configuration of your Oracle databases can be hard. With Puppet at your side, you get super-powers when installing and managing Oracle Databases. If you want to play and experiment with this [please take a look at our playgrounds](https://www.enterprisemodules.com/playgrounds#oracle). 

[![Experience the Power](https://raw.githubusercontent.com/enterprisemodules/public_images/master/superpowers-33-blanc.jpg)](https://www.enterprisemodules.com/playgrounds#oracle)


## License

Most of the [Enterprise Modules](https://www.enterprisemodules.com) modules are commercial modules. This one is **NOT**. It is an Open Source module. You are free to use it any way you like. It, however, is based on our commercial Puppet Oracle modules.

## Description

The `ora_profile::database` class contains all the Puppet code to install, create and populate an Oracle database. This class is an easy way to get started. It contains the following stages (These are not puppet stages):

- `sysctl`           (Set all required sysctl parameters)
- `limits`           (Set all required OS limits)
- `packages`         (Install all required packages)
- `groups_and_users` (Create required groups and users)
- `firewall`         (Open required firewall rules)
- `asm_storage`      (Setup storage for use with ASM (skipped by default))
- `asm_software`     (Install Grid Infrastructure/ASM (skipped by default))
- `asm_diskgroup`    (Define all requires ASM diskgroups (skipped by default))
- `db_software`      (Install required Oracle database software)
- `db_patches`       (Install specified Opatch version and install specified patches)
- `db_definition`    (Define the database)
- `db_listener`      (Start the Listener)
- `db_services`      (Define Database Services)
- `db_tablespaces`   (Define all required tablespaces)
- `db_profiles`      (Define all required Oracle profiles)
- `db_users`         (Define all required Oracle users)
- `db_startup`       (Make sure the database restarts after a reboot)

All these stages have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file.

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `limits` is done. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::database::before_sysctl:   my_profile::my_extra_class
```
or after:

```yaml
ora_profile::database::after_sysctl:   my_profile::my_extra_class
```

If you want to, you can also skip this provided class:

```yaml
ora_profile::database::sysctl:   skip
```

Or provide your own implementation:

```yaml
ora_profile::database::sysctl:   my_profile::my_own_implementation
```

This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.

Check [here](https://www.enterprisemodules.com/docs/ora_profile/description.html) to see the full documentation for this module.

## Setup

### Requirements

The [`ora_profile`](https://www.enterprisemodules.com/shop/products/puppet-ora_config-module) module requires:
- Puppet module [`enterprisemodules-ora_config`](https://forge.puppet.com/enterprisemodules/ora_config) installed.
- Puppet module [`enterprisemodules-ora_install`](https://forge.puppet.com/enterprisemodules/ora_install) installed.
- Puppet module [`enterprisemodules-easy_type`](https://forge.puppet.com/enterprisemodules/easy_type) installed.
- Puppet module [`enterprisemodules/ora_secured`](https://forge.puppet.com/enterprisemodules/ora_secured) installed.
- Puppet module [`ipcrm-echo`](https://forge.puppet.com/ipcrm/echo) installed.
- Puppet module [`puppet-augeasproviders_core`](https://forge.puppet.com/herculesteam/augeasproviders_core) installed.
- Puppet module [`herculesteam-augeasproviders_sysctl`](https://forge.puppet.com/herculesteam/augeasproviders_sysctl) installed.
- Puppet module [`saz-limits`](https://forge.puppet.com/saz/limits) installed.
- Puppet module [`puppetlabs-firewall`](https://forge.puppet.com/puppetlabs/firewall) installed.
- Puppet module [`crayfishx-firewalld`](https://forge.puppet.com/crayfishx/firewalld) installed.
- Puppet module [`puppetlabs-stdlib`](https://forge.puppet.com/puppetlabs/stdlib) installed.
- Puppet version 4.0 or higher. Can be Puppet Enterprise or Puppet Open Source
- Oracle 11 higher
- A valid Oracle license
- A valid Enterprise Modules license for usage.
- Runs on most Linux systems.
- Runs on Solaris
- Windows systems are **NOT** supported

### Installing the ora_profile module

To install these modules, you can use a `Puppetfile`

```
mod 'enterprisemodules/ora_profile'               ,'0.1.0'
```

Then use the `librarian-puppet` or `r10K` to install the software.

You can also install the software using the `puppet module`  command:

```
puppet module install enterprisemodules-ora_profile
```

## Usage

To get started, include the `ora_profile::database` class in your role, make sure you have a module called `software` that has a folder `files` and that directory contains the the next files:

- linuxx64_12201_database.zip
- p6880880_122010_Linux-x86-64_12.2.0.1.12.zip (OPatch)
- p27468969_122010_Linux-x86-64.zip (GI APR 2018 RELEASE UPDATE 12.2.0.1.180417)

If you also want to install ASM, the file below also needs to be placed in the `files` directory:

- linuxx64_12201_grid_home

You can download these files from
[here](http://support.oracle.com)
or
[here](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle12c-linux-12201-3608234.html)


Run Puppet and you have a running Oracle 12.2 database called DB01

## Reference

Here you can find some more information regarding this puppet module:

- [The `ora_profile` documentation](https://www.enterprisemodules.com/docs/ora_profile/description.html)

Here are related blog posts:
- [How to ensure you only use Oracle features you paid for](https://www.enterprisemodules.com/blog/2017/09/how-to-ensure-you-only-use-oracle-features-you-paid-for/)
- [Oracle 12.2 support added to our Oracle modules](https://www.enterprisemodules.com/blog/2017/03/oracle12-2-support/)
- [Secure your Oracle Database](https://www.enterprisemodules.com/blog/2017/02/secure-your-oracle-database/)
- [Manage Oracle containers with Puppet](https://www.enterprisemodules.com/blog/2017/01/manage-oracle-containers-with-puppet/)
- [Manage your oracle users with Puppet](https://www.enterprisemodules.com/blog/2016/10/manage-oracle-users-with-puppet/)
- [Reaching into your Oracle Database with Puppet](https://www.enterprisemodules.com/blog/2015/12/reaching-into-your-oracle-database-with-puppet/)
- [Manage your Oracle database schemas with Puppet](https://www.enterprisemodules.com/blog/2015/12/manage-your-oracle-database-schemas-with-puppet/)
- [Managing your Oracle database size with Puppet](https://www.enterprisemodules.com/blog/2015/11/managing-your-oracle-database-size-with-puppet/)
- [Using Puppet to manage Oracle](https://www.enterprisemodules.com/blog/2014/02/using-puppet-to-manage-oracle/)

## Limitations

This module runs on Solaris, AIX and most Linux versions. It requires a puppet version higher than 4. The module does **NOT** run on windows systems.
