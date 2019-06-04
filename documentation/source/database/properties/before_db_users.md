The name of the class you want to execute directly **before** the `db_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_db_users:  my_module::my_class
```
