---
title: groups and users
keywords: documentation
layout: documentation
sidebar: ora_profile_sidebar
toc: false
---
## Overview

This class contains the definition of all required OS users and groups on this system.

When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.




## Attributes



Attribute Name                     | Short Description                        |
---------------------------------- | ---------------------------------------- |
[groups](#groups_and_users_groups) | The list of groups to create for Oracle. |
[users](#groups_and_users_users)   | The OS users to create for Oracle.       |




### users<a name='groups_and_users_users'>

The OS users to create for Oracle.

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
Type: `'user',`



[Back to overview of groups_and_users](#attributes)

### groups<a name='groups_and_users_groups'>

The list of groups to create for Oracle.

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

Type: `Hash`



[Back to overview of groups_and_users](#attributes)
