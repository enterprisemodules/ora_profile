Use this value if you want to skip or use your own class for stage `asm_init_params`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::asm_init_params:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::asm_init_params:  skip
```
