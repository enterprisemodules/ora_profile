#++--++
#
# ora_profile::groups_and_users
#
# @summary This class contains the definition of all required OS users and groups on this system.
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Hash] users
#    The OS users to create for Oracle.
#    The default value is:
#    ```yaml
#    ora_profile::database::groups_and_users::users:
#      oracle:
#        uid:        54321
#        gid:        oinstall
#        groups:
#        - oinstall
#        - dba
#        - oper
#        shell:      /bin/bash
#        password:   '$1$DSJ51vh6$4XzzwyIOk6Bi/54kglGk3.'
#        home:       /home/oracle
#        comment:    This user oracle was created by Puppet
#        managehome: true
#    ```
#
# @param [Hash] groups
#    The list of groups to create for Oracle.
#    The default value is:
#    ```yaml
#    ora_profile::database::groups_and_users::groups:
#      oinstall:
#        gid:  54321,
#      dba:
#        gid:  54322,
#      oper:
#        gid:  54323,
#    ```
#
#--++--
class ora_profile::database::groups_and_users(
  Hash  $users,
  Hash  $groups,
) inherits ora_profile::database {

  if $groups.size > 0 {
    $groups_list = $groups.keys
    echo {"Ensure Group(s) ${groups_list.join(',')}":
      withpath => false,
    }
  }

  if $users.size > 0 {
    $users_list = $users.keys
    echo {"Ensure User(s) ${users_list.join(',')}":
      withpath => false,
    }
  }

  $defaults = { 'ensure' => 'present'}
  ensure_resources('user', $users, $defaults )
  ensure_resources('group', $groups, $defaults)
}
