# ora_profile::client
#
# install's an Oracle client n a system
#
#
# @example
#   ora_profile::client 
#++--++

#--++--
class ora_profile::client(
  Optional[String] $before_em_license       = undef,
  Optional[String] $em_license              = undef,
  Optional[String] $after_em_license        = undef,
  Optional[String] $before_groups_and_users = undef,
  Optional[String] $groups_and_users        = undef,
  Optional[String] $after_groups_and_users  = undef,
  Optional[String] $before_packages         = undef,
  Optional[String] $packages                = undef,
  Optional[String] $after_packages          = undef,
  Optional[String] $before_software         = undef,
  Optional[String] $software                = undef,
  Optional[String] $after_software          = undef,
)
{
  easy_type::staged_contain([
    'ora_profile::database::em_license',
    'ora_profile::database::groups_and_users',
    'ora_profile::client::packages',
    'ora_profile::client::software',
  ])
}
