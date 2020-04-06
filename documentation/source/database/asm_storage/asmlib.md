This class configures ASMLib devices.

Here is an example:

```puppet
  include ora_profile::database::asm_storage::asmlib
```

<%- include_attributes [
  :grid_user,
  :grid_admingroup,
  :disk_devices,
  :scan_exclude,
]%>
