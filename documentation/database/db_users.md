---
title: database::db users
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for all the database users you'd like on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                   | Short Description                   |
-------------------------------- | ----------------------------------- |
[list](#database::db_users_list) | A list of database users to define. |




### list<a name='database::db_users_list'>

A list of database users to define.

You must specify a Hash of [ora_user](/docs/ora_config/ora_user.html)

The default value is: `{}`

This is a simple way to get started. It is easy to get started, but soon your hiera yaml become a nigtmare. Our advise is when you need to let puppet manage your Oracle profiles, to override this class and  add your own puppet implementation. This is much better maintainable
and adds more consistency.

Type: `Hash`


[Back to overview of database::db_users](#attributes)
