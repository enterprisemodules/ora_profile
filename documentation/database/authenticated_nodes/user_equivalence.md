---
title: database::authenticated nodes::user equivalence
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Setup user equivalence for the specified user on specified nodes.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                                                              | Short Description            |
--------------------------------------------------------------------------- | ---------------------------- |
[nodes](#database::authenticated_nodes::user_equivalence_nodes)             |                              |
[private_key](#database::authenticated_nodes::user_equivalence_private_key) | The private key of the user. |




### private_key<a name='database::authenticated_nodes::user_equivalence_private_key'>

The private key of the user.

Type: `String`


[Back to overview of database::authenticated_nodes::user_equivalence](#attributes)

### nodes<a name='database::authenticated_nodes::user_equivalence_nodes'>

The cluster nodes.
Type: `Array[String[1]]`

Default:`['localhost']`

[Back to overview of database::authenticated_nodes::user_equivalence](#attributes)
