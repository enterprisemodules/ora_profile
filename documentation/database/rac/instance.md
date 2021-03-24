---
title: database::rac::instance
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Add Undo tablespace, Thread and init parameters for RAC instances

Here is an example:
  ora_profile::database::rac::instance{'instance_name'}




If you want to play and experiment with this type, please take a look at our playgrounds. At our playgrounds, 
we provide you with a pre-installed environment, where you experiment with these Puppet types.

Look at our playgrounds [here](/playgrounds#oracle)

## Attributes



Attribute Name                                                  | Short Description                                                         |
--------------------------------------------------------------- | ------------------------------------------------------------------------- |
[datafile](#database::rac::instance_datafile)                   | The datafile for the Undo tablespace for the instance.                    |
[log_size](#database::rac::instance_log_size)                   | The size of the redolog files of the instance.                            |
[number](#database::rac::instance_number)                       | The instance number.                                                      |
[on](#database::rac::instance_on)                               | The instance for which it should be executed.                             |
[thread](#database::rac::instance_thread)                       | The thread of the instance.                                               |
[undo_autoextend](#database::rac::instance_undo_autoextend)     | Auto extensibility of the Undo tablespace for the instance.               |
[undo_initial_size](#database::rac::instance_undo_initial_size) | The size of the Undo tablespace for the instance.                         |
[undo_max_size](#database::rac::instance_undo_max_size)         | The maximum size of the datafile of the Undo tablespace for the instance. |
[undo_next](#database::rac::instance_undo_next)                 | The size of the next extent for the Undo tablesapce of the instance.      |




### on<a name='database::rac::instance_on'>

The instance for which it should be executed.

Type: `String[1]`


[Back to overview of database::rac::instance](#attributes)

### number<a name='database::rac::instance_number'>

The instance number.

Type: `Integer`


[Back to overview of database::rac::instance](#attributes)

### thread<a name='database::rac::instance_thread'>

The thread of the instance.

Type: `Integer`


[Back to overview of database::rac::instance](#attributes)

### datafile<a name='database::rac::instance_datafile'>

The datafile for the Undo tablespace for the instance.

Type: `String[1]`


[Back to overview of database::rac::instance](#attributes)

### undo_initial_size<a name='database::rac::instance_undo_initial_size'>

The size of the Undo tablespace for the instance.

Type: `Easy_type::Size`


[Back to overview of database::rac::instance](#attributes)

### undo_next<a name='database::rac::instance_undo_next'>

The size of the next extent for the Undo tablesapce of the instance.

Type: `Easy_type::Size`


[Back to overview of database::rac::instance](#attributes)

### undo_autoextend<a name='database::rac::instance_undo_autoextend'>

Auto extensibility of the Undo tablespace for the instance.

Type: `Enum['on','off']`


[Back to overview of database::rac::instance](#attributes)

### undo_max_size<a name='database::rac::instance_undo_max_size'>

The maximum size of the datafile of the Undo tablespace for the instance.

Type: `Easy_type::Size`


[Back to overview of database::rac::instance](#attributes)

### log_size<a name='database::rac::instance_log_size'>

The size of the redolog files of the instance.

Type: `Easy_type::Size`


[Back to overview of database::rac::instance](#attributes)
