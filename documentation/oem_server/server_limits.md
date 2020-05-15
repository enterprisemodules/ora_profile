---
title: oem server::server limits
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition all the required OS limit settings for OEM on your system.




## Attributes



Attribute Name                          | Short Description                 |
--------------------------------------- | --------------------------------- |
[list](#oem_server::server_limits_list) | The OS limits created for Oracle. |




### list<a name='oem_server::server_limits_list'>

The OS limits created for Oracle.

The defaults are:

```yaml
ora_profile::oem::server_limits::list:
  '*/nproc':
    soft: 4098
    hard: 8192
```

[Back to overview of oem_server::server_limits](#attributes)
