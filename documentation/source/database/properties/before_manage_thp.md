The name of the class you want to execute directly **before** the `manage_thp` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_manage_thp:  my_module::my_class
```
