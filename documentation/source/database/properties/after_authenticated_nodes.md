The name of the class you want to execute directly **after** the `authenticated_nodes` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_authenticated_nodes:  my_module::my_class
```
