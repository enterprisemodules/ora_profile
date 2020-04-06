This class contains the code to install Oracle Grid Infrastructure.
Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :version,
  :dirs,
  :file_name,
  :asm_sys_password,
  :disk_discovery_string,
  :asm_diskgroup,
  :asm_disks,
  :group,
  :oper_group,
  :asm_group,
  :configure_afd,
  :grid_type,
  :disk_redundancy,
  :bash_profile,
  :disks_failgroup_names,
  :cluster_name,
  :scan_name,
  :scan_port,
  :cluster_node_types,
  :network_interface_list,
  :storage_option
]%>
