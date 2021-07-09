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