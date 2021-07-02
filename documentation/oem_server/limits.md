---
title: oem server::limits
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition all the required OS limit settings for OEM Server on your system.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                   | Short Description                 |
-------------------------------- | --------------------------------- |
[list](#oem_server::limits_list) | The OS limits created for Oracle. |




### list<a name='oem_server::limits_list'>

The OS limits created for Oracle.

The defaults are:

```yaml
ora_profile::oem_server::limits::list:
  '*/nproc':
    soft: 4098
    hard: 8192
```

[Back to overview of oem_server::limits](#attributes)
