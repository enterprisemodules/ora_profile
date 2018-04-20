# ora_profile::database
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   ora_profile::database { 'database_name': }
class ora_profile::database(
  Optional[String] $sysctl = undef,
  Optional[String] $limits = undef,
  Optional[String] $packages = undef,
  Optional[String] $groups_and_users = undef,
  Optional[String] $firewall = undef,
  Optional[String] $db_software = undef,
  Optional[String] $db_patches = undef,
  Optional[String] $db_definition = undef,
  Optional[String] $db_listener = undef,
  Optional[String] $db_services = undef,
  Optional[String] $db_tablespaces = undef,
  Optional[String] $db_profiles = undef,
  Optional[String] $db_users = undef,
  Optional[String] $db_startup = undef,
  Optional[String] $before_sysctl = undef,
  Optional[String] $before_limits = undef,
  Optional[String] $before_packages = undef,
  Optional[String] $before_groups_and_users = undef,
  Optional[String] $before_firewall = undef,
  Optional[String] $before_db_software = undef,
  Optional[String] $before_db_patches = undef,
  Optional[String] $before_db_definition = undef,
  Optional[String] $before_db_listener = undef,
  Optional[String] $before_db_services = undef,
  Optional[String] $before_db_tablespaces = undef,
  Optional[String] $before_db_profiles = undef,
  Optional[String] $before_db_users = undef,
  Optional[String] $before_db_startup = undef,
  Optional[String] $after_sysctl = undef,
  Optional[String] $after_limits = undef,
  Optional[String] $after_packages = undef,
  Optional[String] $after_groups_and_users = undef,
  Optional[String] $after_firewall = undef,
  Optional[String] $after_db_software = undef,
  Optional[String] $after_db_patches = undef,
  Optional[String] $after_db_definition = undef,
  Optional[String] $after_db_listener = undef,
  Optional[String] $after_db_services = undef,
  Optional[String] $after_db_tablespaces = undef,
  Optional[String] $after_db_profiles = undef,
  Optional[String] $after_db_users = undef,
  Optional[String] $after_db_startup = undef,
)
{
  easy_type::staged_contain([
    'ora_profile::database::sysctl',
    'ora_profile::database::limits',
    'ora_profile::database::packages',
    'ora_profile::database::groups_and_users',
    'ora_profile::database::firewall',
    'ora_profile::database::db_software',
    'ora_profile::database::db_patches',
    'ora_profile::database::db_definition',
    'ora_profile::database::db_listener',
    'ora_profile::database::db_services',
    'ora_profile::database::db_tablespaces',
    'ora_profile::database::db_profiles',
    'ora_profile::database::db_users',
    'ora_profile::database::db_startup',
  ])
}
