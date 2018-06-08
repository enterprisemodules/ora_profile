This class contains the code to install Oracle Grid Infrastructure.
Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :version,
  :dirs,
  :grid_user,
  :grid_group,
  :grid_base,
  :grid_home,
  :source,
  :file_name,
  :asm_sys_password,
]%>
