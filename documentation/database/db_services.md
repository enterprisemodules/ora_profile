---
title: database::db services
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of all the database services you'd like on your system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





If you want to play and experiment with this type, please take a look at our playgrounds. At our playgrounds, 
we provide you with a pre-installed environment, where you experiment with these Puppet types.

Look at our playgrounds [here](/playgrounds#oracle)

## Attributes



Attribute Name                                    | Short Description         |
------------------------------------------------- | ------------------------- |
[dbname](#database::db_services_dbname)           | The name of the database. |
[domain_name](#database::db_services_domain_name) |                           |




### dbname<a name='database::db_services_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database::db_services](#attributes)

### domain_name<a name='database::db_services_domain_name'>


Type: `Optional[String[1]]`


[Back to overview of database::db_services](#attributes)
