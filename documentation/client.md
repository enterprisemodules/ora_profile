---
title: client
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This is a highly customizable Puppet profile class to define an Oracle client on your system. In it's core just adding:

```
contain ora_profile::client
```

Is enough to get an client installed on your system. 

But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.

## Stages

Defining an Oracle client on you system goes through several stages(These are not puppet stages):

- `packages`         (Install all required packages)
- `groups_and_users` (Create required groups and users)
- `software`         (Install the Oracle client software )

All these stages have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 

## before classes

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `packages` stage is done and before the `groups_and_users` is started. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::client::before_groups_and_users:   my_profile::my_extra_class
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
contain ::ora_profile::client
```






## Attributes



Attribute Name                                             | Short Description                                                                           |
---------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
[after_em_license](#client_after_em_license)               | The name of the class you want to execute directly **after** the `em_license` class.        |
[after_groups_and_users](#client_after_groups_and_users)   | The name of the class you want to execute directly **after** the `groups_and_users` class.  |
[after_packages](#client_after_packages)                   | The name of the class you want to execute directly **after** the `packages` class.          |
[after_software](#client_after_software)                   | The name of the class you want to execute directly **after** the `software` class.          |
[before_em_license](#client_before_em_license)             | The name of the class you want to execute directly **before** the `em_license` class.       |
[before_groups_and_users](#client_before_groups_and_users) | The name of the class you want to execute directly **before** the `groups_and_users` class. |
[before_packages](#client_before_packages)                 | The name of the class you want to execute directly **before** the `packages` class.         |
[before_software](#client_before_software)                 | The name of the class you want to execute directly **before** the `software` class.         |
[em_license](#client_em_license)                           | Use this value if you want to skip or use your own class for stage `em_license`.            |
[groups_and_users](#client_groups_and_users)               | Use this value if you want to skip or use your own class for stage `groups_and_users`.      |
[packages](#client_packages)                               | Use this value if you want to skip or use your own class for stage `packages`.              |
[software](#client_software)                               | Use this value if you want to skip or use your own class for stage `software`.              |




### before_em_license<a name='client_before_em_license'>

The name of the class you want to execute directly **before** the `em_license` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_em_license:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### em_license<a name='client_em_license'>

Use this value if you want to skip or use your own class for stage `em_license`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::em_license:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::em_license:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### after_em_license<a name='client_after_em_license'>

The name of the class you want to execute directly **after** the `em_license` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_em_license:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### before_groups_and_users<a name='client_before_groups_and_users'>

The name of the class you want to execute directly **before** the `groups_and_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_groups_and_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### groups_and_users<a name='client_groups_and_users'>

Use this value if you want to skip or use your own class for stage `groups_and_users`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::groups_and_users:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::groups_and_users:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### after_groups_and_users<a name='client_after_groups_and_users'>

The name of the class you want to execute directly **after** the `groups_and_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_groups_and_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### before_packages<a name='client_before_packages'>

The name of the class you want to execute directly **before** the `packages` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_packages:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### packages<a name='client_packages'>

Use this value if you want to skip or use your own class for stage `packages`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::packages:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::packages:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### after_packages<a name='client_after_packages'>

The name of the class you want to execute directly **after** the `packages` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_packages:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### before_software<a name='client_before_software'>

The name of the class you want to execute directly **before** the `software` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_software:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### software<a name='client_software'>

Use this value if you want to skip or use your own class for stage `software`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::software:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::software:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)

### after_software<a name='client_after_software'>

The name of the class you want to execute directly **after** the `software` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_software:  my_module::my_class
```


Type: `Optional[String]`

Default:`undef`

[Back to overview of client](#attributes)
