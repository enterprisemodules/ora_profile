The name of the class you want to execute directly **before** the `em_license` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_em_license:  my_module::my_class
```
