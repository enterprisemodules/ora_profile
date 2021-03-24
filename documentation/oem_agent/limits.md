---
title: oem agent::limits
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition all the required OS limit settings for OEM Agent on your system.




If you want to play and experiment with this type, please take a look at our playgrounds. At our playgrounds, 
we provide you with a pre-installed environment, where you experiment with these Puppet types.

Look at our playgrounds [here](/playgrounds#oracle)

## Attributes



Attribute Name                  | Short Description                 |
------------------------------- | --------------------------------- |
[list](#oem_agent::limits_list) | The OS limits created for Oracle. |




### list<a name='oem_agent::limits_list'>

The OS limits created for Oracle.

The defaults are:

```yaml
ora_profile::oem_agent::limits::list:
  '*/nproc':
    soft: 4096
    hard: 16384
```


[Back to overview of oem_agent::limits](#attributes)
