This class contains the definition for the Oracle patches. It also contains the definition of the required `Opatch` version.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :patch_file,
  :oracle_home,
  :opversion,
  :install_group,
  :os_user,
  :source,
  :patch_list,
]%>

