---
title: db users
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition for all the database users you'd like on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name         | Short Description                   |
---------------------- | ----------------------------------- |
[list](#db_users_list) | A list of database users to define. |




### list<a name='db_users_list'>



A list of database users to define.

The default value is: `{}`

This is a simple way to get started. It is easy to get started, but soon your hiera yaml become a nigtmare. Our advise is when you need to let puppet manage your Oracle profiles, to override this class and  add your own puppet implementation. This is much better maintainable
and adds more consistency.

[Back to overview of db_users](#attributes)

