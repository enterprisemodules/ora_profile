The Hash with parameters that need to be configured.


You must specify a Hash of [ora_init_param](/docs/ora_config/ora_init_param.html)


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