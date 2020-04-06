This class will apply udev rules to specified disk devices.

Here is an example:

```puppet
  include ora_profile::database::asm_storage::udev
```

<%- include_attributes [
  :grid_user,
  :grid_admingroup,
  :disk_devices,
]%>
