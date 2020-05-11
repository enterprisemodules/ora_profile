The home directory to use for the Oracle installation.

The default is : `/u01/app/oracle/product/#{version}/db_home1`

To customize this consistently use the hiera key `ora_profile::database::oracle_home` for a single ORACLE_HOME.

This parameter can also be specified as Hash if you need to install multiple ORACLE_HOME's.
The keys of the hash are just a name.
For every key all parameters that are valid for ora_install::installdb can be specified.

For example:

```yaml
ora_profile::database::db_software::oracle_home:
  18cORACLE_HOME1:
    version:     "%{lookup('ora_profile::database::version')}"
    file:        "%{lookup('ora_profile::database::db_software::file_name')}"
    oracle_home: "/u01/app/oracle/product/%{lookup('ora_profile::database::version')}/db_home1"
  18cORACLE_HOME2:
    version:     "%{lookup('ora_profile::database::version')}"
    file:        "%{lookup('ora_profile::database::db_software::file_name')}"
    oracle_home: "/u01/app/oracle/product/%{lookup('ora_profile::database::version')}/db_home2"
  12cR1ORACLE_HOME1:
    version:     12.1.0.2
    file:        linuxamd64_12102_database
    oracle_home: /u01/app/oracle/product/12.1.0.2/db_home1
  12cR1ORACLE_HOME2:
    version:     12.1.0.2
    file:        linuxamd64_12102_database
    oracle_home: /u01/app/oracle/product/12.1.0.2/db_home2
  12cR1ORACLE_HOME3:
    version:     12.1.0.2
    file:        linuxamd64_12102_database
    oracle_home: /u01/app/oracle/product/12.1.0.2/db_home3
  12cR2ORACLE_HOME1:
    version:      12.2.0.1
    file:         linuxx64_12201_database
    oracle_home: /u01/app/oracle/product/12.2.0.1/db_home1
```
