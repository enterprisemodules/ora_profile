This is a highly customizable Puppet profile class to define an Oracle client on your system. In it's core just adding:

```
contain ora_profile::client
```

Is enough to get an client installed on your system. 

But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.

## Stages

Defining and starting an Oracle database on you system goes through several stages(These are not puppet stages):

- `packages`         (Install all required packages)
- `groups_and_users` (Create required groups and users)
- `software`         (Install the Oracle client software )

All these stages have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 

## before classes

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `limits` is done. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::client::before_packages:   my_profile::my_extra_class
```

## after classes

You can do the same when you want to add code after one of the stage classes:

```yaml
ora_profile::client::after_packages:   my_profile::my_extra_class
```

## Skipping

Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:

```yaml
ora_profile::client::packages:   skip
```

## Replacing

Or provide your own implementation:

```yaml
ora_profile::client::packages:   my_profile::my_own_implementation
```

This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.

Here is an example:
```puppet
contain ora_profile::client
```


<%- include_attributes [
  :before_em_license,
  :em_license,
  :after_em_license,
  :before_groups_and_users,
  :groups_and_users,
  :after_groups_and_users,
  :before_packages,
  :packages,
  :after_packages,
  :before_software,
  :software,
  :after_software
]%>

