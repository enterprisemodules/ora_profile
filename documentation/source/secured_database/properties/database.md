Use this value if you want to skip or use your own class for stage `database`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::database:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::database:  skip
```
