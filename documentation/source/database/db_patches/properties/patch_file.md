The file containing the required Opatch version.

The default value is: `p6880880_122010_Linux-x86-64`

The value can be a String or a Hash. When the value is a string, the file specified will be used to upgrade OPatch in every ORACLE_HOME on the system.
If you want to install different versions in different ORACLE_HOME's you can specify a patch_file per ORACLE_HOME like below.

When you specify a Hash, it must have the following format:

```yaml
ora_profile::database::db_patches::patch_file:
  /u01/app/oracle/product/23.0.0.0/db_home1:
    patch_file: p6880880_230000_Linux-x86-64-12.2.0.1.48
  /u01/app/oracle/product/21.0.0.0/db_home1:
    patch_file: p6880880_210000_Linux-x86-64
    opversion:  12.2.0.1.35
  /u01/app/oracle/product/19.0.0.0/db_home1
    patch_file: p6880880_190000_Linux-x86-64
    opversion:  12.2.0.1.37
  /u01/app/oracle/product/18.0.0.0/db_home1
    patch_file: p6880880_180000_Linux-x86-64
  /u01/app/oracle/product/12.2.0.1/db_home1:
    patch_file: p6880880_122010_Linux-x86-64-12.2.0.1.21
    opversion:  12.2.0.1.21
```
