---
title: database::db monitoring
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of the db monitoring facility to install.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.






## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                            | Short Description                                                     |
--------------------------------------------------------- | --------------------------------------------------------------------- |
[data_path](#database::db_monitoring_data_path)           | The directory where you want to store the data of the facility.       |
[facility](#database::db_monitoring_facility)             | The facility you want to install.                                     |
[file_name](#database::db_monitoring_file_name)           | The file_name that contains the facility you want to install.         |
[install_path](#database::db_monitoring_install_path)     | The directory where you want to install the facility.                 |
[os_user](#database::db_monitoring_os_user)               | The OS user to use for Oracle install.                                |
[oswbb_compress](#database::db_monitoring_oswbb_compress) | The utility that will be used to compress the data.                   |
[oswbb_days](#database::db_monitoring_oswbb_days)         | The number of days the data will be kept in the data_path.            |
[oswbb_interval](#database::db_monitoring_oswbb_interval) | The interval at which the facility will gather a snapshot in seconds. |




### data_path<a name='database::db_monitoring_data_path'>

The directory where you want to store the data of the facility.
For oswbb this will default to the archive directory inside the directory that is extracted from the file_name.

The default value is: undef

Type: `Optional[Stdlib::Absolutepath]`

Default:`undef`

[Back to overview of database::db_monitoring](#attributes)

### facility<a name='database::db_monitoring_facility'>

The facility you want to install.
Currrently only OSWatcher Black Box (oswbb) is supported, Autonomous Health Framework (ahf) soon to come.

The default value is:

```yaml
ora_profile::database::db_monitoring::facility: oswbb
```

Type: `Enum['oswbb','ahf']`


[Back to overview of database::db_monitoring](#attributes)

### file_name<a name='database::db_monitoring_file_name'>

The file_name that contains the facility you want to install.

The default value is:

```yaml
ora_profile::database::db_monitoring::file_name: oswbb840.tar
```

Type: `String[1]`


[Back to overview of database::db_monitoring](#attributes)

### install_path<a name='database::db_monitoring_install_path'>

The directory where you want to install the facility.

The default value is: '/u01'

Type: `Stdlib::Absolutepath`


[Back to overview of database::db_monitoring](#attributes)

### os_user<a name='database::db_monitoring_os_user'>

The OS user to use for Oracle install.

The default is : `oracle`

To customize this consistently use the hiera key `ora_profile::database::os_user`.

Type: `String[1]`


[Back to overview of database::db_monitoring](#attributes)

### oswbb_compress<a name='database::db_monitoring_oswbb_compress'>

The utility that will be used to compress the data.

The default value is:

```yaml
ora_profile::database::db_monitoring::oswbb_compress: gzip
```

Type: `String[1]`


[Back to overview of database::db_monitoring](#attributes)

### oswbb_days<a name='database::db_monitoring_oswbb_days'>

The number of days the data will be kept in the data_path.

The default value is:

```yaml
ora_profile::database::db_monitoring::oswbb_days: 2
```

Type: `Integer`


[Back to overview of database::db_monitoring](#attributes)

### oswbb_interval<a name='database::db_monitoring_oswbb_interval'>

The interval at which the facility will gather a snapshot in seconds.

The default value is:

```yaml
ora_profile::database::db_monitoring::oswbb_interval: 30
```

Type: `Integer`


[Back to overview of database::db_monitoring](#attributes)
