The name of the class you want to execute directly **after** the `asm_software` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_asm_software:  my_module::my_class
```
