This class sets up the storage for usage by ASM.
Currently only NFS is supported as storage_type. ASMLIB and AFD will be added in a future release.
Here you can customize some of the attributes of your storage.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :storage_type,
  :grid_user,
  :grid_admingroup,
  :nfs_files,
  :nfs_mountpoint,
  :nfs_export,
  :nfs_server,
]%>
