Use this value if you want to skip or use your own class for stage `manage_thp`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::manage_thp:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::manage_thp:  skip
```
