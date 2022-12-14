---
title: oem server
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This is a highly customizable Puppet profile class to define an Oracle Enterprise Manager installation on your system. In it's core just adding:

```puppet
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
- `limits`             (Set all required OS limits)
- `packages`           (Install all required packages)
- `software`           (Install the Oracle Enterprise Manager software)

All these stages have a default implementation. This implementation is suitable to get started with. These classes all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file.

## before classes

But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `groups_and_users` is started. You can do this by adding the next line to your yaml data:

```yaml
ora_profile::oem_server::before_groups_and_users:   my_profile::my_extra_class
```

## after classes

You can do the same when you want to add code after one of the stage classes:

```yaml
ora_profile::oem_server::after_groups_and_users:   my_profile::my_extra_class
```

## Skipping

Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:

```yaml
ora_profile::oem_server::packages:   skip
```

## Replacing

Or provide your own implementation:

```yaml
ora_profile::oem_server::packages:   my_profile::my_own_implementation
```

This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.

Here is an example:

```puppet
contain ::ora_profile::oem_server
```





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                                 | Short Description                                                                           |
-------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
[after_em_license](#oem_server_after_em_license)               | The name of the class you want to execute directly **after** the `em_license` class.        |
[after_firewall](#oem_server_after_firewall)                   | The name of the class you want to execute directly **after** the `firewall` class.          |
[after_groups_and_users](#oem_server_after_groups_and_users)   | The name of the class you want to execute directly **after** the `groups_and_users` class.  |
[after_limits](#oem_server_after_limits)                       | The name of the class you want to execute directly **after** the `limits` class.            |
[after_packages](#oem_server_after_packages)                   | The name of the class you want to execute directly **after** the `packages` class.          |
[after_software](#oem_server_after_software)                   | The name of the class you want to execute directly **after** the `software` class.          |
[after_sysctl](#oem_server_after_sysctl)                       | The name of the class you want to execute directly **after** the `sysctl` class.            |
[before_em_license](#oem_server_before_em_license)             | The name of the class you want to execute directly **before** the `em_license` class.       |
[before_firewall](#oem_server_before_firewall)                 | The name of the class you want to execute directly **before** the `firewall` class.         |
[before_groups_and_users](#oem_server_before_groups_and_users) | The name of the class you want to execute directly **before** the `groups_and_users` class. |
[before_limits](#oem_server_before_limits)                     | The name of the class you want to execute directly **before** the `limits` class.           |
[before_packages](#oem_server_before_packages)                 | The name of the class you want to execute directly **before** the `packages` class.         |
[before_software](#oem_server_before_software)                 | The name of the class you want to execute directly **before** the `software` class.         |
[before_sysctl](#oem_server_before_sysctl)                     | The name of the class you want to execute directly **before** the `sysctl` class.           |
[em_license](#oem_server_em_license)                           | Use this value if you want to skip or use your own class for stage `em_license`.            |
[firewall](#oem_server_firewall)                               | Use this value if you want to skip or use your own class for stage `firewall`.              |
[groups_and_users](#oem_server_groups_and_users)               | Use this value if you want to skip or use your own class for stage `groups_and_users`.      |
[limits](#oem_server_limits)                                   | Use this value if you want to skip or use your own class for stage `limits`.                |
[packages](#oem_server_packages)                               | Use this value if you want to skip or use your own class for stage `packages`.              |
[software](#oem_server_software)                               | Use this value if you want to skip or use your own class for stage `software`.              |
[standalone](#oem_server_standalone)                           | Indicate if this is a standalone (Only install OEM) or not (Install database and OEM)
      |
[sysctl](#oem_server_sysctl)                                   | Use this value if you want to skip or use your own class for stage `sysctl`.                |




### after_em_license<a name='oem_server_after_em_license'>

The name of the class you want to execute directly **after** the `em_license` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_em_license:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### after_firewall<a name='oem_server_after_firewall'>

The name of the class you want to execute directly **after** the `firewall` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_firewall:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### after_groups_and_users<a name='oem_server_after_groups_and_users'>

The name of the class you want to execute directly **after** the `groups_and_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_groups_and_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### after_limits<a name='oem_server_after_limits'>

The name of the class you want to execute directly **after** the `limits` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::after_limits:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### after_packages<a name='oem_server_after_packages'>

The name of the class you want to execute directly **after** the `packages` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::after_packages:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### after_software<a name='oem_server_after_software'>

The name of the class you want to execute directly **after** the `software` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::after_software:  my_module::my_class
```


Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### after_sysctl<a name='oem_server_after_sysctl'>

The name of the class you want to execute directly **after** the `sysctl` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::after_sysctl:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### before_em_license<a name='oem_server_before_em_license'>

The name of the class you want to execute directly **before** the `em_license` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_em_license:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### before_firewall<a name='oem_server_before_firewall'>

The name of the class you want to execute directly **before** the `firewall` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_firewall:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### before_groups_and_users<a name='oem_server_before_groups_and_users'>

The name of the class you want to execute directly **before** the `groups_and_users` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_groups_and_users:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### before_limits<a name='oem_server_before_limits'>

The name of the class you want to execute directly **before** the `limits` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::before_limits:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### before_packages<a name='oem_server_before_packages'>

The name of the class you want to execute directly **before** the `packages` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::before_packages:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### before_software<a name='oem_server_before_software'>

The name of the class you want to execute directly **before** the `software` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::before_software:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### before_sysctl<a name='oem_server_before_sysctl'>

The name of the class you want to execute directly **before** the `sysctl` class.

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::before_sysctl:  my_module::my_class
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### em_license<a name='oem_server_em_license'>

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

[Back to overview of oem_server](#attributes)

### firewall<a name='oem_server_firewall'>

Use this value if you want to skip or use your own class for stage `firewall`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::firewall:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::firewall:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### groups_and_users<a name='oem_server_groups_and_users'>

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

[Back to overview of oem_server](#attributes)

### limits<a name='oem_server_limits'>

Use this value if you want to skip or use your own class for stage `limits`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::limits:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::limits:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### packages<a name='oem_server_packages'>

Use this value if you want to skip or use your own class for stage `packages`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::packages:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::packages:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### software<a name='oem_server_software'>

Use this value if you want to skip or use your own class for stage `software`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::software:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::oem_server::software:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### standalone<a name='oem_server_standalone'>

Indicate if this is a standalone (Only install OEM) or not (Install database and OEM)

Valid values are `true` and `false`.

Type: `Optional[Boolean]`

Default:`undef`

[Back to overview of oem_server](#attributes)

### sysctl<a name='oem_server_sysctl'>

Use this value if you want to skip or use your own class for stage `sysctl`.

## Use your own class

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::sysctl:  my_module::my_class
```

## Skip

You can use hiera to set this value. Here is an example:

```yaml
ora_profile::database::sysctl:  skip
```

Type: `Optional[String]`

Default:`undef`

[Back to overview of oem_server](#attributes)
