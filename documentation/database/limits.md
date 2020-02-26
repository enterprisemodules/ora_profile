---
title: database::limits
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition all the required OS limit settings on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                 | Short Description                 |
------------------------------ | --------------------------------- |
[list](#database::limits_list) | The OS limits created for Oracle. |




### list<a name='database::limits_list'>

The OS limits created for Oracle.

The defaults are:

```yaml
ora_profile::database::limits::list:
  '*/nofile':
    soft: 2048
    hard: 8192
  'oracle/nofile':
    soft: 65536
    hard: 65536
  'oracle/nproc':
    soft: 2048
    hard: 16384
  'oracle/stack':
    soft: 10240
    hard: 32768
```
Type: `Hash`


[Back to overview of database::limits](#attributes)
