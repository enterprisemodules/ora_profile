# ora_profile::database
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   ora_profile::database { 'database_name': }
#++--++
#--++--
class ora_profile::extracted_database (
# lint:ignore:parameter_documentation
# lint:ignore:strict_indent
  String[1] $db_control_provider,
  String[1] $dba_group,
  String[1] $dbname,
  Stdlib::Absolutepath
            $download_dir,
  String[1] $install_group,
  Stdlib::Absolutepath
            $ora_inventory_dir,
  Stdlib::Absolutepath
            $oracle_base,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $os_user,
  String[1] $source,
  Stdlib::Absolutepath
            $temp_dir,
  Ora_Install::Version $version,
  Optional[String[1]] $after_db_patches =undef,
  Optional[String[1]] $after_db_software =undef,
  Optional[String[1]] $after_db_startup =undef,
  Optional[String[1]] $after_em_license =undef,
  Optional[String[1]] $after_extracted_database_definition =undef,
  Optional[String[1]] $after_extracted_init_params =undef,
  Optional[String[1]] $after_extracted_profiles =undef,
  Optional[String[1]] $after_extracted_services =undef,
  Optional[String[1]] $after_extracted_tablespaces =undef,
  Optional[String[1]] $after_extracted_users =undef,
  Optional[String[1]] $after_firewall =undef,
  Optional[String[1]] $after_groups_and_users =undef,
  Optional[String[1]] $after_limits =undef,
  Optional[String[1]] $after_packages =undef,
  Optional[String[1]] $after_sysctl =undef,
  Optional[String[1]] $after_tmpfiles =undef,
  Optional[String]    $authenticated_nodes = undef,
  Optional[String[1]] $before_db_patches =undef,
  Optional[String[1]] $before_db_software =undef,
  Optional[String[1]] $before_db_startup =undef,
  Optional[String[1]] $before_em_license =undef,
  Optional[String[1]] $before_extracted_database_definition =undef,
  Optional[String[1]] $before_extracted_init_params =undef,
  Optional[String[1]] $before_extracted_profiles =undef,
  Optional[String[1]] $before_extracted_services =undef,
  Optional[String[1]] $before_extracted_tablespaces =undef,
  Optional[String[1]] $before_extracted_users =undef,
  Optional[String[1]] $before_firewall =undef,
  Optional[String[1]] $before_groups_and_users =undef,
  Optional[String[1]] $before_limits =undef,
  Optional[String[1]] $before_packages =undef,
  Optional[String[1]] $before_sysctl =undef,
  Optional[String[1]] $before_tmpfiles =undef,
  Optional[String[1]] $db_patches =undef,
  Optional[String[1]] $db_software =undef,
  Optional[String[1]] $db_startup =undef,
  Optional[String]    $em_license = undef,
  Optional[String[1]] $extracted_database_definition =undef,
  Optional[String[1]] $extracted_init_params =undef,
  Optional[String[1]] $extracted_profiles =undef,
  Optional[String[1]] $extracted_services =undef,
  Optional[String[1]] $extracted_tablespaces =undef,
  Optional[String[1]] $extracted_users =undef,
  Optional[String[1]] $firewall =undef,
  Optional[String[1]] $groups_and_users =undef,
  Optional[String[1]] $limits =undef,
#
# Optional settings
#
  Optional[String]    $oracle_user_password = undef,
  Optional[String[1]] $packages =undef,
  Optional[String[1]] $sysctl =undef,
  Optional[String[1]] $tmpfiles =undef
) inherits ora_profile::database::common {
# lint:endignore:strict_indent
  easy_type::debug_evaluation() # Show local variable on extended debug

  easy_type::ordered_steps([
      'ora_profile::database::em_license',
      ['ora_profile::database::sysctl',                   { 'implementation' => 'easy_type::profile::sysctl' }],
      ['ora_profile::database::limits',                   { 'implementation' => 'easy_type::profile::limits' }],
      ['ora_profile::database::groups_and_users',         { 'implementation' => 'easy_type::profile::groups_and_users' }],
      ['ora_profile::database::packages',                 { 'implementation' => 'easy_type::profile::packages' }],
      #
      # Although there is an easy_type::profile::firewall implementation, it doesn't fit here. We are doing more here
      #
      'ora_profile::database::firewall',
      'ora_profile::database::tmpfiles',
      'ora_profile::database::db_software',
      'ora_profile::database::db_patches',
      ['ora_profile::database::extracted_database_definition', { 'implementation' => 'easy_type::profile::resources' }],
      ['ora_profile::database::extracted_init_params',         { 'implementation' => 'easy_type::profile::resources' }],
      ['ora_profile::database::extracted_services',            { 'implementation' => 'easy_type::profile::resources' }],
      ['ora_profile::database::extracted_tablespaces',         { 'implementation' => 'easy_type::profile::resources' }],
      ['ora_profile::database::extracted_profiles',            { 'implementation' => 'easy_type::profile::resources' }],
      ['ora_profile::database::extracted_users',               { 'implementation' => 'easy_type::profile::resources' }],
      'ora_profile::database::db_startup',
  ])
}
# lint:endignore:parameter_documentation
