This class contains the definition of the Oracle software you want to use on this system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :version,
  :database_type,
  :dirs,
  :dba_group,
  :oper_group,
  :os_user,
  :oracle_base,
  :oracle_home,
  :source,
  :file_name,
  :bash_profile,
  :bash_additions,
]%>
