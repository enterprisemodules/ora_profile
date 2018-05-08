This is a highly customizable Puppet profile class to define an Oracle database on your system. In it's core just adding:

```
contain ora_profile::database
```

Is enough to get an Oracle 12.2 database running on your system. 

But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.

## Stages

Defining and starting an Oracle database on you system goes through several stages(These are not puppet stages):

- `sysctl`           (Set all required sysctl parameters)
- `limits`           (Set all required OS limits)
- `packages`         (Install all required packages)
- `groups_and_users` (Create required groups and users)
- `firewall`         (Open required firewall rules)
- `db_software`      (Install required Oracle database software)
- `db_patches`       (Install specified Opatch version and install specified patches)
- `db_definition`    (Define the database)
- `db_listener`      (Start the Listener)
- `db_services`      (Define Database Services)
- `db_tablespaces`   (Define all required tablespaces)
- `db_profiles`      (Define all required Oracle profiles)
- `db_users`         (Define all required Oracle users)
- `db_startup`       (Make sure the database restarts after a reboot)

All these stages have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 

## before classes

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `limits` is done. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::database::before_sysctl:   my_profile::my_extra_class
```

## after classes

You can do the same when you want to add code after one of the stage classes:

```yaml
ora_profile::database::after_sysctl:   my_profile::my_extra_class
```

## Skipping

Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:

```yaml
ora_profile::database::sysctl:   skip
```

## Replacing

Or provide your own implementation:

```yaml
ora_profile::database::sysctl:   my_profile::my_own_implementation
```

This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.

Look at the description of the stages and their properties.

At this level you can also customize some generic settings. Check the settings for:

- `version`
- `dbname`
- `os_user`
- `dba_group`
- `install_group`
- `source`
- `oracle_base`
- `oracle_home`

Here is an example on how you can do this:

```puppet

class {'ora_profile::database':
  dbname  => 'EM',
  source  => 'http://www.example.com/database_files',
  version => '11.2.0.3',
}

```


<%- include_attributes [
  :version,
  :dbname,
  :os_user,
  :dba_group,
  :install_group,
  :source,
  :oracle_base,
  :oracle_home,
  :sysctl,
  :limits,
  :packages,
  :groups_and_users,
  :firewall,
  :db_software,
  :db_patches,
  :db_definition,
  :db_listener,
  :db_services,
  :db_tablespaces,
  :db_profiles,
  :db_users,
  :db_startup,
  :before_sysctl,
  :before_limits,
  :before_packages,
  :before_groups_and_users,
  :before_firewall,
  :before_db_software,
  :before_db_patches,
  :before_db_definition,
  :before_db_listener,
  :before_db_services,
  :before_db_tablespaces,
  :before_db_profiles,
  :before_db_users,
  :before_db_startup,
  :after_sysctl,
  :after_limits,
  :after_packages,
  :after_groups_and_users,
  :after_firewall,
  :after_db_software,
  :after_db_patches,
  :after_db_definition,
  :after_db_listener,
  :after_db_services,
  :after_db_tablespaces,
  :after_db_profiles,
  :after_db_users,
  :after_db_startup,
]%>

