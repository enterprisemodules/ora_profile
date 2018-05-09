# ora_profile::secured_db
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::secured_db
class ora_profile::secured_database(
  Optional[String] $database = undef,
  Optional[String] $cis_rules = undef,
  Optional[String] $before_database = undef,
  Optional[String] $before_cis_rules = undef,
  Optional[String] $after_database = undef,
  Optional[String] $after_cis_rules = undef,
) {
  easy_type::staged_contain([
    'ora_profile::database',
    'ora_profile::database::cis_rules',
  ])
}
