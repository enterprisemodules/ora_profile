This class contains the definition for the Oracle patches. It also contains the definition of the required `Opatch` version.

The class allows you to specify a patch level and optionally include the OJVM pacthes for the level specified.
A patch_list to specify additional patches is also supported.

Keep in mind that when changing the patch level and/or adding patches will cause the listener(s) and database(s) to be stopped and started.

Applying patches to database software in a RAC environment is only supported on initial run.
There is no support yet to apply patches on a running system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :patch_file,
  :oracle_home,
  :opversion,
  :install_group,
  :os_user,
  :source,
  :patch_list,
  :level,
  :logoutput,
  :include_ojvm,
]%>

