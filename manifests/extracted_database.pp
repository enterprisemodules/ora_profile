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
class ora_profile::database(
  Enum['local','asm']  $storage,
  Ora_Install::Version $version,
  String[1] $dbname,
  String[1] $os_user,
  String[1] $dba_group,
  String[1] $install_group,
  String[1] $grid_user,
  String[1] $grid_admingroup,
  String[1] $source,
  Stdlib::Absolutepath
            $oracle_base,
  Stdlib::Absolutepath
            $oracle_home,
  Stdlib::Absolutepath
            $ora_inventory_dir,
  Stdlib::Absolutepath
            $grid_base,
  Stdlib::Absolutepath
            $grid_home,
  String[1] $db_control_provider,
  Stdlib::Absolutepath
            $download_dir,
  Stdlib::Absolutepath
            $temp_dir,
#
# Optional settings
#
  Optional[String] $oracle_user_password = undef,
 
  Optional[String] $em_license = undef,
  Optional[String] $authenticated_nodes = undef,
  Optional[String] $sysctl = undef,
  Optional[String] $limits = undef,
  Optional[String] $packages = undef,
  Optional[String] $groups_and_users = undef,
  Optional[String] $firewall = undef,
  Optional[String] $tmpfiles = undef,
  Optional[String] $db_software = undef,
  Optional[String] $db_patches = undef,
  Optional[String] $db_definition = undef,
  Optional[String] $db_listener = undef,
  Optional[String] $db_init_params = undef,
  Optional[String] $db_services = undef,
  Optional[String] $db_tablespaces = undef,
  Optional[String] $db_profiles = undef,
  Optional[String] $db_users = undef,
  Optional[String] $db_startup = undef,
  Optional[String] $before_em_license = undef,
  Optional[String] $before_sysctl = undef,
  Optional[String] $before_limits = undef,
  Optional[String] $before_packages = undef,
  Optional[String] $before_groups_and_users = undef,
  Optional[String] $before_firewall = undef,
  Optional[String] $before_tmpfiles = undef,
  Optional[String] $before_db_software = undef,
  Optional[String] $before_db_patches = undef,
  Optional[String] $before_db_definition = undef,
  Optional[String] $before_db_listener = undef,
  Optional[String] $before_db_init_params = undef,
  Optional[String] $before_db_services = undef,
  Optional[String] $before_db_tablespaces = undef,
  Optional[String] $before_db_profiles = undef,
  Optional[String] $before_db_users = undef,
  Optional[String] $before_db_startup = undef,
  Optional[String] $after_em_license = undef,
  Optional[String] $after_sysctl = undef,
  Optional[String] $after_limits = undef,
  Optional[String] $after_packages = undef,
  Optional[String] $after_groups_and_users = undef,
  Optional[String] $after_firewall = undef,
  Optional[String] $after_tmpfiles = undef,
  Optional[String] $after_db_software = undef,
  Optional[String] $after_db_patches = undef,
  Optional[String] $after_db_definition = undef,
  Optional[String] $after_db_listener = undef,
  Optional[String] $after_db_init_params = undef,
  Optional[String] $after_db_services = undef,
  Optional[String] $after_db_tablespaces = undef,
  Optional[String] $after_db_profiles = undef,
  Optional[String] $after_db_users = undef,
  Optional[String] $after_db_startup = undef,
)
{
  $is_linux                  = $::kernel == 'Linux'
  $is_windows                = $::kernel == 'Windows'

  easy_type::debug_evaluation() # Show local variable on extended debug

  easy_type::ordered_steps([
    'ora_profile::database::em_license',
    ['ora_profile::database::sysctl',                   {'implementation' => 'easy_type::profile::sysctl' }],
    ['ora_profile::database::limits',                   {'implementation' => 'easy_type::profile::limits' }],
    ['ora_profile::database::groups_and_users',         { 'implementation' => 'easy_type::profile::groups_and_users' }],
    ['ora_profile::database::packages',                 {'implementation' => 'easy_type::profile::packages' }],
    #
    # Although there is an easy_type::profile::firewall implementation, it doesn't fit here. We are doing more here
    #
    'ora_profile::database::firewall',
    'ora_profile::database::tmpfiles',
    'ora_profile::database::db_software',
    'ora_profile::database::db_patches',
    'ora_profile::database::database_definition',
    'ora_profile::database::db_listener',
    'ora_profile::database::db_init_params',
    'ora_profile::database::db_services',
    'ora_profile::database::db_tablespaces',
    'ora_profile::database::db_profiles',
    'ora_profile::database::db_users',
    'ora_profile::database::db_startup',
  ])
}
