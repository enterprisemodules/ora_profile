---
title: database::groups and users
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of all required OS users and groups on this system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.





## Experience the Power of Puppet for Oracle

If you want to play and experiment with Puppet and Oracle, please take a look at our playgrounds. At our playgrounds, we provide you with a pre-installed environment, where you experiment fast and easy.

{% include super_hero.html title="For Oracle" ref="/playgrounds#oracle" %}


## Attributes



Attribute Name                               | Short Description                        |
-------------------------------------------- | ---------------------------------------- |
[groups](#database::groups_and_users_groups) | The list of groups to create for Oracle. |
[users](#database::groups_and_users_users)   | The OS users to create for Oracle.       |




### users<a name='database::groups_and_users_users'>

The OS users to create for Oracle.

You must specify a Hash of [users](https://puppet.com/docs/puppet/6/types/user.html)

The default value is:

```yaml
ora_profile::database::groups_and_users::users:
  oracle:
    uid:        54321
    gid:        oinstall
    groups:
    - oinstall
    - dba
    - oper
    shell:      /bin/bash
    password:   '$1$DSJ51vh6$4XzzwyIOk6Bi/54kglGk3.'
    home:       /home/oracle
    comment:    This user oracle was created by Puppet
    managehome: true
```

[Back to overview of database::groups_and_users](#attributes)

### groups<a name='database::groups_and_users_groups'>

The list of groups to create for Oracle.

You must specify a Hash of [groups](https://puppet.com/docs/puppet/6/types/group.html)

The default value is:

```yaml
ora_profile::database::groups_and_users::groups:
  oinstall:
    gid:  54321,
  dba:
    gid:  54322,
  oper:
    gid:  54323,

```


[Back to overview of database::groups_and_users](#attributes)
