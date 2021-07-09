The OS limits created for Oracle.

You must specify a Hash of [limits](https://forge.puppet.com/modules/saz/limits)


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