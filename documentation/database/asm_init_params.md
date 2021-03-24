---
title: database::asm init params
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class configures initialization parameters for the ASM instance

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




If you want to play and experiment with this type, please take a look at our playgrounds. At our playgrounds, 
we provide you with a pre-installed environment, where you experiment with these Puppet types.

Look at our playgrounds [here](/playgrounds#oracle)

## Attributes



Attribute Name                                      | Short Description                                    |
--------------------------------------------------- | ---------------------------------------------------- |
[parameters](#database::asm_init_params_parameters) | The Hash with parameters that need to be configured. |




### parameters<a name='database::asm_init_params_parameters'>

The Hash with parameters that need to be configured.
The keys of the hash represent the parameter you want to set.
Notation: '<scope>/<parameter_name>[:for_sid][@sid]'

```yaml
ora_profile::database::asm_init_params::parameters:
  memory/asm_power_limit:
    ensure: present
    value: 1024
  spfile/asm_power_limit:
    ensure: present
    value: 1024
```

```yaml
ora_profile::database::db_init_params::parameters:
  memory/archive_lag_target:
    ensure: present
    value: 1800
  spfile/archive_lag_target:
    ensure: present
    value: 1800
```

See: [ora_init_params](https://www.enterprisemodules.com/docs/ora_config/ora_init_param.html)
Type: `Hash`

Default:`{}`

[Back to overview of database::asm_init_params](#attributes)
