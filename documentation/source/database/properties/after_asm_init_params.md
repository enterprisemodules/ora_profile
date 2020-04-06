The name of the class you want to execute directly **after** the `asm_init_params` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_asm_init_params:  my_module::my_class
```
