---
title: secured database
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

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





## Attributes



Attribute Name                                         | Short Description                                                                    |
------------------------------------------------------ | ------------------------------------------------------------------------------------ |
[after_cis_rules](#secured_database_after_cis_rules)   | The name of the class you want to execute directly **after** the `cis_rules` class.  |
[after_database](#secured_database_after_database)     | The name of the class you want to execute directly **after** the `database` class.   |
[before_cis_rules](#secured_database_before_cis_rules) | The name of the class you want to execute directly **before** the `cis_rules` class. |
[before_database](#secured_database_before_database)   | The name of the class you want to execute directly **before** the `database` class.  |
[cis_rules](#secured_database_cis_rules)               | Use this value if you want to skip or use your own class for stage `cis_rules`.      |
[database](#secured_database_database)                 | Use this value if you want to skip or use your own class for stage `database`.       |




### database<a name='secured_database_database'>

Use this value if you want to skip or use your own class for stage `database`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::database:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::database:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of secured_database](#attributes)

### cis_rules<a name='secured_database_cis_rules'>

Use this value if you want to skip or use your own class for stage `cis_rules`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::cis_rules:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::cis_rules:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of secured_database](#attributes)

### before_database<a name='secured_database_before_database'>

The name of the class you want to execute directly **before** the `database` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::before_database:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of secured_database](#attributes)

### before_cis_rules<a name='secured_database_before_cis_rules'>

The name of the class you want to execute directly **before** the `cis_rules` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::before_cis_rules:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of secured_database](#attributes)

### after_database<a name='secured_database_after_database'>

The name of the class you want to execute directly **after** the `database` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::after_database:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of secured_database](#attributes)

### after_cis_rules<a name='secured_database_after_cis_rules'>

The name of the class you want to execute directly **after** the `cis_rules` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::secured_database::after_cis_rules:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of secured_database](#attributes)
