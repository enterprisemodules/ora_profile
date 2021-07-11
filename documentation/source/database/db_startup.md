This class contains the definition for the auto startup of Oracle after a system reboot.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

Also check the set of [common parameters](./common) that is passed to this class.

<%- include_attributes [
  :oracle_home,
  :dbname,
  :db_type,
]%>
