Use this value if you want to skip or use your own class for stage `asm_groups_and_users`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::asm_groups_and_users:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::asm_groups_and_users:  skip
```
