Use this value if you want to use your own class, skip or enable for stage `rman_config`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::rman_config:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::rman_config:  skip
```

This is the default from the ora_profile module.
To enable the rman configuration class define the variable as `undef`:

```yaml
ora_profile::database::rman_config:  ~
```
