The name of the class you want to execute directly **after** the `cis_rules` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::after_cis_rules:  my_module::my_class
```
