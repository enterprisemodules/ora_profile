This class contains the definition of the firewall settings you need for Oracle.

When you are using a Redhat flavored version lower then release 7, this module uses the `puppetlabs-firewall` module to manage the `iptables` settings. When using a version 7 or higher, the puppet module `crayfishx-firewalld` to manage the `firewalld daemon`.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :ports,
  :manage_service,
]%>

