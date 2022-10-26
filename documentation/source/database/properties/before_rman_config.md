The name of the class you want to execute directly **before** the `rman_config` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_rman_config:  my_module::my_class
```
