The disk devices that should be used.
Dependant on value specified for `ora_profile::database::asm_storage::storage_type`

Here is an example:

```yaml
ora_profile::database::asm_storage::disk_devices:
  asm_data01:
    size: 8192
    uuid: '1ATA_VBOX_HARDDISK_VB00000000-01000000'
    label: 'DATA1'
```
