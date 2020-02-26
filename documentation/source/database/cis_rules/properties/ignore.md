Name the CIS rules you don't want to apply (e.g. ignore) to your database.

An example:

```yaml
ora_profile::database::cis_rules::ignore:
  - r_1_1
  ...
  - r_2_1_4
```

The default is:

```yaml
  - r_1_1
  - r_2_1_1
  - r_2_1_2
  - r_2_1_3
  - r_2_1_4
```

These are actualy the rules that don't secure anything *inside* of a database.