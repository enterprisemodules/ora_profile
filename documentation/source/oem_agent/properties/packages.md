Use this value if you want to skip or use your own class for stage `packages`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::packages:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::packages:  skip
```
