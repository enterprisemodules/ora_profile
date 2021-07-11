This class contains the definition for the ASM patches. It also contains the definition of the required `Opatch` version.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

Also check the set of [common parameters](./common) that is passed to this class.

<%- include_attributes [
  :level,
  :patch_file,
  :opversion,
  :patch_list,
  :logoutput,
]%>

