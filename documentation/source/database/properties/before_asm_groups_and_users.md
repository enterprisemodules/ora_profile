The name of the class you want to execute directly **before** the `asm_groups_and_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_asm_groups_and_users:  my_module::my_class
```
