The name of the class you want to execute directly **before** the `fact_caching` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_fact_caching:  my_module::my_class
```