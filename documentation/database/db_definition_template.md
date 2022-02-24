---
title: database::db definition template
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the actual database definition using the `ora_install::database` class. In this class the database will be created from a template. When using a 'seed' template, this will significantly decrease the time it takes to create a database. Bij default the Oracle supplied General_Purpose template is used, which is probably not the best option for your production environment.
This class is meant to replace the db_definition class by specifying in your yaml file:

```yaml
ora_profile::database::before_sysctl:  my_module::my_class
```

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                                                           | Short Description                                                  |
---------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
[container_database](#database::db_definition_template_container_database)               | Database is a container for pluggable databases.                   |
[data_file_destination](#database::db_definition_template_data_file_destination)         | The location where you want to store your database files.          |
[db_conf_type](#database::db_definition_template_db_conf_type)                           | The type of database that needs to be installed.                   |
[dbdomain](#database::db_definition_template_dbdomain)                                   | The domain of the database.                                        |
[dbname](#database::db_definition_template_dbname)                                       | The name of the database.                                          |
[init_params](#database::db_definition_template_init_params)                             | The init parameters to use for the database.                       |
[log_size](#database::db_definition_template_log_size)                                   | The log ize to use.                                                |
[logoutput](#database::db_definition_template_logoutput)                                 | log the outputs of Puppet exec or not.                             |
[memory_mgmt_type](#database::db_definition_template_memory_mgmt_type)                   | How the database memory should be managed.                         |
[oracle_base](#database::db_definition_template_oracle_base)                             | The base directory to use for the Oracle installation.             |
[oracle_home](#database::db_definition_template_oracle_home)                             | The home directory to use for the Oracle installation.             |
[puppet_download_mnt_point](#database::db_definition_template_puppet_download_mnt_point) | Where to get the source of your template from.                     |
[recovery_area_destination](#database::db_definition_template_recovery_area_destination) | The location where you want to store your flash recovery area.     |
[sample_schema](#database::db_definition_template_sample_schema)                         | Specify if you want the sample schemas installed in your database. |
[storage_type](#database::db_definition_template_storage_type)                           | What type of storage is used for your database.                    |
[sys_password](#database::db_definition_template_sys_password)                           | The `sys` password to use for the database.                        |
[system_password](#database::db_definition_template_system_password)                     | The `system` password to use for the database.                     |
[template_name](#database::db_definition_template_template_name)                         | The name of the template to use for creating the database
         |
[template_type](#database::db_definition_template_template_type)                         | What type of template is used for creating the database.           |
[version](#database::db_definition_template_version)                                     | The version of Oracle you want to install.                         |




### version<a name='database::db_definition_template_version'>

The version of Oracle you want to install.

The default is : `12.2.0.1`

To customize this consistently use the hiera key `ora_profile::database::version`.

Type: `Ora_Install::Version`


[Back to overview of database::db_definition_template](#attributes)

### oracle_home<a name='database::db_definition_template_oracle_home'>

The home directory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_definition_template](#attributes)

### oracle_base<a name='database::db_definition_template_oracle_base'>

The base directory to use for the Oracle installation.

The default is : `/u01/app/oracle`

To customize this consistently use the hiera key `ora_profile::database::install_group`.


Type: `Stdlib::Absolutepath`


[Back to overview of database::db_definition_template](#attributes)

### dbname<a name='database::db_definition_template_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database::db_definition_template](#attributes)

### template_name<a name='database::db_definition_template_template_name'>

The name of the template to use for creating the database

The default value is `General_Purpose.${version}`
Type: `String[1]`


[Back to overview of database::db_definition_template](#attributes)

### template_type<a name='database::db_definition_template_template_type'>

What type of template is used for creating the database.

The default value is `seed`
Type: `Enum['non-seed','seed']`


[Back to overview of database::db_definition_template](#attributes)

### data_file_destination<a name='database::db_definition_template_data_file_destination'>

The location where you want to store your database files. A filesystem or ASM location can be specified.

The default value is `+DATA`
Type: `String[1]`


[Back to overview of database::db_definition_template](#attributes)

### recovery_area_destination<a name='database::db_definition_template_recovery_area_destination'>

The location where you want to store your flash recovery area. A filesystem or ASM location can be specified.

The default value is `+RECO`
Type: `String[1]`


[Back to overview of database::db_definition_template](#attributes)

### sample_schema<a name='database::db_definition_template_sample_schema'>

Specify if you want the sample schemas installed in your database.

The default value is `FALSE`
Type: `Enum['TRUE','FALSE']`


[Back to overview of database::db_definition_template](#attributes)

### memory_mgmt_type<a name='database::db_definition_template_memory_mgmt_type'>

How the database memory should be managed.

The default value is `AUTO_SGA`

Type: `Enum['AUTO','AUTO_SGA','CUSTOM_SGA']`


[Back to overview of database::db_definition_template](#attributes)

### storage_type<a name='database::db_definition_template_storage_type'>

What type of storage is used for your database.

The default value is `ASM`
Type: `Enum['FS','CFS','ASM']`


[Back to overview of database::db_definition_template](#attributes)

### puppet_download_mnt_point<a name='database::db_definition_template_puppet_download_mnt_point'>

Where to get the source of your template from. This is the module where the xml file for your template is stored as a puppet template(erb).

The default value is `ora_profile`
Type: `String[1]`


[Back to overview of database::db_definition_template](#attributes)

### system_password<a name='database::db_definition_template_system_password'>

The `system` password to use for the database.

The default value is: `Welcome01`
Type: `Easy_type::Password`


[Back to overview of database::db_definition_template](#attributes)

### sys_password<a name='database::db_definition_template_sys_password'>

The `sys` password to use for the database.

The default value is: `Change_on_1nstall`
Type: `Easy_Type::Password`


[Back to overview of database::db_definition_template](#attributes)

### db_conf_type<a name='database::db_definition_template_db_conf_type'>

The type of database that needs to be installed.

Valid values are:
- `SINGLE`
- `RAC`
- `RACONE`

The default value is `SINGLE`
Type: `Enum['SINGLE','RAC','RACONE']`


[Back to overview of database::db_definition_template](#attributes)

### container_database<a name='database::db_definition_template_container_database'>

Database is a container for pluggable databases.
When you want to add pluggable database to this database, specify a value of `enabled`.

The default value is: `disabled`

Type: `Enum['enabled','disabled']`


[Back to overview of database::db_definition_template](#attributes)

### log_size<a name='database::db_definition_template_log_size'>

The log ize to use.

The default is : `100M`
Type: `String[1]`


[Back to overview of database::db_definition_template](#attributes)

### dbdomain<a name='database::db_definition_template_dbdomain'>

The domain of the database.

The default is `$facts['networking']['domain']`

Type: `Optional[String[1]]`


[Back to overview of database::db_definition_template](#attributes)

### init_params<a name='database::db_definition_template_init_params'>

The init parameters to use for the database.

You can use either a comma separated string for init_params or a Hash.

### Using comma separated string

Here is an example using a comma separated string:

``` yaml
ora_profile::database::db_definition_template::init_params: "open_cursors=1000,processes=600,job_queue_processes=4"
```

### Using a Hash

Here is an example using a Hash:

``` yaml
ora_profile::database::db_definition_template::init_params:
  open_cursors: 1000
  processes: 600
  job_queue_processes: 4
```

Type: `Optional[Variant[String[1],Hash]]`


[Back to overview of database::db_definition_template](#attributes)

### logoutput<a name='database::db_definition_template_logoutput'>

log the outputs of Puppet exec or not.

When you specify `true` Puppet will log all output of `exec` types.

Valid values are:

- `true`
- `false`
- `on_failure`

Type: `Variant[Boolean,Enum['on_failure']]`

Default:`lookup( { name => 'logoutput', default_value => 'on_failure' })`

[Back to overview of database::db_definition_template](#attributes)
