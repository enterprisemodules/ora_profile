This is a highly customizable Puppet profile class to define an Oracle Enterprise Manager installation on your system. In it's core just adding:

```
contain ::ora_profile::oem_server
```

Is enough to get Oracle Enterprise Manager installed on your system. 

But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.

## Stages

Defining and starting an Oracle Enterprise Manager installation on you system goes through several stages(These are not puppet stages):

- `em_license`         (Deploy Enterprise Modules license)
- `sysctl`             (Set all required sysctl parameters)
- `groups_and_users`   (Create required groups and users)
- `firewall`           (Open required firewall rules)
- `server_limits`      (Set all required OS limits)
- `server_packages`    (Install all required packages)
- `server`             (Install the Oracle Enterprise Manager software)

All these stages have a default implementation. This implementation is suitable to get started with. These classes all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 

## before classes

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `groups_and_users` is started. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::oem::before_groups_and_users:   my_profile::my_extra_class
```

## after classes

You can do the same when you want to add code after one of the stage classes:

```yaml
ora_profile::oem::after_groups_and_users:   my_profile::my_extra_class
```

## Skipping

Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:

```yaml
ora_profile::oem::server_packages:   skip
```

## Replacing

Or provide your own implementation:

```yaml
ora_profile::oem::server_packages:   my_profile::my_own_implementation
```

This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.

Here is an example:
```puppet
contain ::ora_profile::oem_server
```


<%- include_attributes [
  :before_em_license,
  :em_license,
  :after_em_license,
  :before_sysctl,
  :sysctl,
  :after_sysctl,
  :before_groups_and_users,
  :groups_and_users,
  :after_groups_and_users,
  :before_firewall,
  :firewall,
  :after_firewall,
  :before_limits,
  :limits,
  :after_limits,
  :before_packages,
  :packages,
  :after_packages,
  :before_software,
  :software,
  :after_software,
  :standalone
]%>

