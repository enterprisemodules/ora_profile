The name of the class you want to execute directly **before** the `database` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::before_database:  my_module::my_class
```
