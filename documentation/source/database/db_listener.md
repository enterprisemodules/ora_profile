This class contains the definition of the Oracle listener process. It installs the specified version of the SQL*net software and start's the listener.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.


 <%- include_attributes [
  :oracle_home,
  :oracle_base,
  :sqlnet_version,
]%>
