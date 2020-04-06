The name of the class you want to execute directly **before** the `asm_limits` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_asm_limits:  my_module::my_class
```
