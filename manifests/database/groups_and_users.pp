# ora_profile::database::groups_and_users
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::groups_and_users
class ora_profile::database::groups_and_users(
  Hash  $users,
  Hash  $groups,
) {
  echo {'Groups and Users':}
  $defaults = { 'ensure' => 'present'}
  create_resources('user', $users, $defaults )
  create_resources('group', $groups, $defaults)
}
