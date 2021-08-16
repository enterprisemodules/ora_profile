This class contains the actual database definition using the `ora_install::database` class. In this class the database will be created from a template. When using a 'seed' template, this will significantly decrease the time it takes to create a database. Bij default the Oracle supplied General_Purpose template is used, which is probably not the best option for your production environment.
This class is meant to replace the db_definition class by specifying in your yaml file:

```yaml
ora_profile::database::before_sysctl:  my_module::my_class
```

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :version,
  :oracle_home,
  :oracle_base,
  :dbname,
  :template_name,
  :template_type,
  :data_file_destination,
  :recovery_area_destination,
  :sample_schema,
  :memory_mgmt_type,
  :storage_type,
  :puppet_download_mnt_point,
  :system_password,
  :sys_password,
  :db_conf_type,
  :container_database,
  :log_size,
  :dbdomain,
  :logoutput,
]%>
