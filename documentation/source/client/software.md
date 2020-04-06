Installs the Oracle client software on your system.

Using this classe you can install the Oracle client software on your system.

<%- include_attributes [
  :version,
  :file,
  :oracle_base,
  :oracle_home,
  :db_port,
  :user,
  :user_base_dir,
  :group,
  :group_install,
  :download_dir,
  :temp_dir,
  :install_type,
  :install_options,
  :puppet_download_mnt_point,
  :bash_profile,
  :ora_inventory_dir,
  :logoutput,
  :allow_insecure
]%>
