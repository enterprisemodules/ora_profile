The name of the class you want to execute directly **before** the `db_startup` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_startup:  my_module::my_class
```
