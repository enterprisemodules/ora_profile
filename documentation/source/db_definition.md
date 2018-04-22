This class contains the actual database definition using the `ora_database` type. Here you can customize some of the attributes of your database.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.

<%- include_attributes [
  :version,
  :oracle_home,
  :oracle_base,
  :dbname,
  :log_size,
  :user_tablespace_size,
  :system_tablespace_size,
  :temporary_tablespace_size,
  :undo_tablespace_size,
  :sysaux_tablespace_size,
  :system_password,
  :sys_password,
  :init_ora_template,
]%>
