---
title: database::cis controls
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the actual code secureing the database. Here you ca customise the securtiy by specifying the CIS rules you *don't* want to apply.


When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::secured_database](./secured_database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                             | Short Description                                                    |
---------------------------------------------------------- | -------------------------------------------------------------------- |
[dbname](#database::cis_controls_dbname)                   | The name of the database.                                            |
[doc_version](#database::cis_controls_doc_version)         | The version of the CIS benchmark you want to apply to your database. |
[product_version](#database::cis_controls_product_version) | The database version of the CIS benchmark you want to apply.         |
[skip_list](#database::cis_controls_skip_list)             | This is the list of controls that you want to skip.                  |




### dbname<a name='database::cis_controls_dbname'>

The name of the database.

The default is `DB01`

To customize this consistently use the hiera key `ora_profile::database::dbname`.
Type: `String[1]`


[Back to overview of database::cis_controls](#attributes)

### product_version<a name='database::cis_controls_product_version'>

The database version of the CIS benchmark you want to apply. Although not very logical, you **can** apply an older (or newer) database version to your database.

If you also don't specify a `db_version`, Puppet will detect the version of Oracle running and use this to determine the `db_version`. There is, however, one issue with the detection. On an initial run Puppet canot determine what the Oracle version is. In that case, the ora_secured::ensure_cis defined type will skip applying the CIS benchmark and wait until (hopefully) the next run the version of Oracle for specified sid is available.


Type: `Optional[String[1]]`


[Back to overview of database::cis_controls](#attributes)

### doc_version<a name='database::cis_controls_doc_version'>

The version of the CIS benchmark you want to apply to your database. When you don't specify the `doc_version`, puppet automatically uses the latest version for your current `product_version`. 
Type: `Optional[String[1]]`


[Back to overview of database::cis_controls](#attributes)

### skip_list<a name='database::cis_controls_skip_list'>

This is the list of controls that you want to skip. By default this value is empty, meaning `ora_secured::ensure_cis` will apply **ALL** controls. You must specify the name of the control. 
Type: `Optional[Array[String[1]]]`


[Back to overview of database::cis_controls](#attributes)
