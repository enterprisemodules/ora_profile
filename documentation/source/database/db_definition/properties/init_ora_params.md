The parameters to use in the template specified in `init_ora_template`.

The default value is:

```yaml
ora_profile::database::db_definition::init_ora_params:
  dbname: "%{lookup('ora_profile::database::db_definition::dbname')}"
  dbdomain: "%{lookup('ora_profile::database::db_definition::dbdomain')}"
  db_create_file_dest: "%{lookup('ora_profile::database::db_definition::data_file_destination')}"
  db_recovery_file_dest: "%{lookup('ora_profile::database::db_definition::db_recovery_file_dest')}"
  db_recovery_file_dest_size: 20480m
  compatible: "%{lookup('ora_profile::database::db_definition::version')}"
  oracle_base: "%{lookup('ora_profile::database::db_definition::oracle_base')}"
  container_database: "%{lookup('ora_profile::database::db_definition::container_database')}"
  sga_target: 1024m
  pga_aggregate_target: 256m
  processes: 300
  open_cursors: 300
  db_block_size: 8192
  log_archive_format: '%t_%s_%r.dbf'
  audit_trail: db
  remote_login_passwordfile: EXCLUSIVE
  undo_tablespace: UNDOTBS1
  memory_target: 0
  memory_max_target: 0

```