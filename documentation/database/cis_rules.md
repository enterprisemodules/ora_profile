---
title: database::cis rules
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the actual code secureing the database. Here you ca customise the securtiy by specifying the CIS rules you *don't* want to apply.


When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::secured_database](./secured_database.html) for an explanation on how to do this.




## Attributes



Attribute Name                        | Short Description                                |
------------------------------------- | ------------------------------------------------ |
[dbname](#database::cis_rules_dbname) | The name of the database.                        |
[ignore](#database::cis_rules_ignore) | Name the CIS rules you don't want to apply (e.g. |




### dbname<a name='database::cis_rules_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database::cis_rules](#attributes)

### ignore<a name='database::cis_rules_ignore'>

Name the CIS rules you don't want to apply (e.g. ignore) to your database.

An example:

```yaml
ora_profile::database::cis_rules::ignore:
  - r_1_1
  ...
  - r_2_1_4
```

The default is:

```yaml
  - r_1_1
  - r_2_1_1
  - r_2_1_2
  - r_2_1_3
  - r_2_1_4
```

These are actualy the rules that don't secure anything *inside* of a database.
Type: `Array[String[1]]`


[Back to overview of database::cis_rules](#attributes)
