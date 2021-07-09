The required sysctl parameters for Oracle.

You must specify a Hash of [sysctl](https://forge.puppet.com/modules/herculesteam/augeasproviders_sysctl)

The defaults are:

```yaml
ora_profile::database::sysctl::list:
  'kernel.msgmnb':
    value:  65536
  'kernel.msgmax':
    value:  65536
  'kernel.shmmax':
    value:  4398046511104
  'kernel.shmall':
    value:  4294967296
  'fs.file-max':
    value:  6815744
  'kernel.shmmni':
    value:  4096
  'fs.aio-max-nr':
    value:  1048576
  'kernel.sem':
    value:  '250 32000 100 128'
  'net.ipv4.ip_local_port_range':
    value:  '9000 65500'
  'net.core.rmem_default':
    value:  262144
  'net.core.rmem_max':
    value:  4194304
  'net.core.wmem_default':
    value:  262144
  'net.core.wmem_max':
    value:  1048576
  'kernel.panic_on_oops':
    value:  1
```