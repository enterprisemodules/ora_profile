The name of the class you want to execute directly **after** the `disable_thp` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_disable_thp:  my_module::my_class
```
