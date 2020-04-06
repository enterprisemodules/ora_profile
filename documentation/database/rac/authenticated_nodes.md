---
title: database::rac::authenticated nodes
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

Setup authentication for the cluster nodes. Only applicable for RAC.




## Attributes



Attribute Name                                                               | Short Description                                  |
---------------------------------------------------------------------------- | -------------------------------------------------- |
[grid_private_key](#database::rac::authenticated_nodes_grid_private_key)     | The private key of the grid user.                  |
[keys](#database::rac::authenticated_nodes_keys)                             | Hash with users and the public keys they will get. |
[oracle_private_key](#database::rac::authenticated_nodes_oracle_private_key) | The private key of the oracle user.                |




### oracle_private_key<a name='database::rac::authenticated_nodes_oracle_private_key'>

The private key of the oracle user.

Type: `String[1]`


[Back to overview of database::rac::authenticated_nodes](#attributes)

### grid_private_key<a name='database::rac::authenticated_nodes_grid_private_key'>

The private key of the grid user.

Type: `String[1]`


[Back to overview of database::rac::authenticated_nodes](#attributes)

### keys<a name='database::rac::authenticated_nodes_keys'>

Hash with users and the public keys they will get.

Here is an example:

```yaml
ora_profile::database::rac::authenticated_nodes::keys:
  oracle_for_grid:
    ensure: present
    user: grid
    type: rsa
    key: '<public key>'
  grid_for_oracle:
    ensure: present
    user: oracle
    type: rsa
    key: '<public key>'
```

Type: `Hash`

Default:`{}`

[Back to overview of database::rac::authenticated_nodes](#attributes)
