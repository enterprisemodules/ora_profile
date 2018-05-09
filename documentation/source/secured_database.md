This is a highly customizable Puppet profile class to define an Secured Oracle database on your system. In it's core just adding:

```
contain ora_profile::secured_database
```

Is enough to get a secured Oracle 12.2 database running on your system.

This profile class is based on the more generic [`ora_profile::database`](./database.html) class, but extends this class with securing the database conforming to the Oracle Center for Internet Security (CIS) rules.

But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.

## Stages

Defining and starting an Oracle database on you system goes through several stages(These are not puppet stages):

- [`database`](./database.html)         (Generic database definition)
- [`cis_rules`](./cis_rules.html)       (Apply all Center for Internet Security (CIS) rules for the database )

All these stages have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 

## before classes

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `database` stage is done and before the `cis_rules` is done. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::database::before_cis_rules:   my_profile::my_extra_class
```

## after classes

You can do the same when you want to add code after one of the stage classes:

```yaml
ora_profile::database::after_cis_rules:   my_profile::my_extra_class
```

## Skipping

Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:

```yaml
ora_profile::database::cis_rules:   skip
```

## Replacing

Or provide your own implementation:

```yaml
ora_profile::database::cis_rules:   my_profile::my_own_implementation
```

This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.

Look at the description of the stages and their properties.

<%- include_attributes [
  :database,
  :cis_rules,
  :before_database,
  :before_cis_rules,
  :after_database,
  :after_cis_rules,
]%>

