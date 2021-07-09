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
