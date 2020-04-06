This class adds partition table and partitions to specified device..

Here is an example:

```puppet
  include ora_profile::database::asm_storage::partition
```

<%- include_attributes [
  :raw_device,
  :table_type,
  :wait_for_device,
  :start,
  :end,
]%>
