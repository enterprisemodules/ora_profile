The OS limits created for Oracle.

The defaults are:

```yaml
ora_profile::oem_server::limits::list:
  '*/nproc':
    soft: 4098
    hard: 8192
```