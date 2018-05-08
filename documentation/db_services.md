---
title: db services
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of all the database services you'd like on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Attributes



Attribute Name                          | Short Description         |
--------------------------------------- | ------------------------- |
[dbname](#db_services_dbname)           | The name of the database. |
[domain_name](#db_services_domain_name) |                           |




### dbname<a name='db_services_dbname'>

The name of the database.

The default is `DB01`

To customize this consistenly use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of db_services](#attributes)

### domain_name<a name='db_services_domain_name'>


Type: `Optional[String[1]]`


[Back to overview of db_services](#attributes)
