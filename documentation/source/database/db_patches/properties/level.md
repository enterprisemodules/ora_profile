The patch level the database or grid infrastructure should be patched to.

Default value is: `NONE`

The value can be a String or a Hash. When the value is a string, the current selected Oracle version (e.g. `ora_profile::database::version`) and the current selected oracle home (e.g. `ora_profile::database::oracle_home`) are used to apply the patch.

When you specify a Hash, it must have the following format:

```
ora_profile::database::db_patches::level:
  21cDEFAULT_HOME:
    version:     21.0.0.0
    oracle_home: /u01/app/oracle/product/21.0.0.0/db_home1
    level:       OCT2022RU
  19cDEFAULT_HOME:
    version:     19.0.0.0
    oracle_home: /u01/app/oracle/product/19.0.0.0/db_home1
    level:       OCT2022RU
  18cADDITIONAL_HOME:
    version:     18.0.0.0
    oracle_home: /u01/app/oracle/product/18.0.0.0/db_home1
    level:       APR2021RU
  12cR2ADDITIONAL_HOME:
    version:     12.2.0.1
    oracle_home: /u01/app/oracle/product/12.2.0.1/db_home1
    level:       JAN2022RU
```
When no level is specified, the level `NONE` is inferred and no level of patches are applied. You can alywas use `patch_list` to specify a specific list of patches to be applied.
