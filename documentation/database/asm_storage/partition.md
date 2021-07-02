---
title: database::asm storage::partition
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class adds partition table and partitions to specified device..

Here is an example:

```puppet
  include ora_profile::database::asm_storage::partition
```





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                                       | Short Description                        |
-------------------------------------------------------------------- | ---------------------------------------- |
[end](#database::asm_storage::partition_end)                         | The end point of the partition.          |
[raw_device](#database::asm_storage::partition_raw_device)           | The device that needs to be partitioned. |
[start](#database::asm_storage::partition_start)                     | The start point of the partition.        |
[table_type](#database::asm_storage::partition_table_type)           |                                          |
[wait_for_device](#database::asm_storage::partition_wait_for_device) |                                          |




### raw_device<a name='database::asm_storage::partition_raw_device'>

The device that needs to be partitioned.

Type: `Stdlib::Absolutepath`


[Back to overview of database::asm_storage::partition](#attributes)

### table_type<a name='database::asm_storage::partition_table_type'>

The type of partition table.
Type: `Enum['gpt','msdos']`

Default:`'msdos'`

[Back to overview of database::asm_storage::partition](#attributes)

### wait_for_device<a name='database::asm_storage::partition_wait_for_device'>

Should we wait for the device to be available?

Type: `Boolean`

Default:`false`

[Back to overview of database::asm_storage::partition](#attributes)

### start<a name='database::asm_storage::partition_start'>

The start point of the partition.

Type: `Optional[Easy_type::Size]`

Default:`undef`

[Back to overview of database::asm_storage::partition](#attributes)

### end<a name='database::asm_storage::partition_end'>

The end point of the partition.

Type: `Optional[Easy_type::Size]`

Default:`undef`

[Back to overview of database::asm_storage::partition](#attributes)
