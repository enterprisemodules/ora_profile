The name of the class you want to execute directly **after** the `db_services` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_services:  my_module::my_class
```
