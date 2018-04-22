The name of the class you want to execute directly **after** the `db_patches` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_db_patches:  my_module::my_class
```
