# ora_profile::database
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   ora_profile::database { 'database_name': }
#++--++
#
# ora_profile::database
#
# @summary This is a highly customizable Puppet profile class to define an Oracle database on your system.
# In it's core just adding:
# 
# ```
# contain ora_profile::database
# ```
# 
# Is enough to get an Oracle 12.2 database running on your system. 
# 
# But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.
# 
# ## Stages
# 
# Defining and starting an Oracle database on you system goes through several stages(These are not puppet stages):
# 
# - `sysctl`           (Set all required sysctl parameters)
# - `limits`           (Set all required OS limits)
# - `packages`         (Install all required packages)
# - `groups_and_users` (Create required groups and users)
# - `firewall`         (Open required firewall rules)
# - `asm_storage`      (Setup storage for use with ASM (skipped by default))
# - `asm_software`     (Install Grid Infrastructure/ASM (skipped by default))
# - `asm_diskgroup`    (Define all requires ASM diskgroups (skipped by default))
# - `db_software`      (Install required Oracle database software)
# - `db_patches`       (Install specified Opatch version and install specified patches)
# - `db_definition`    (Define the database)
# - `db_listener`      (Start the Listener)
# - `db_services`      (Define Database Services)
# - `db_tablespaces`   (Define all required tablespaces)
# - `db_profiles`      (Define all required Oracle profiles)
# - `db_users`         (Define all required Oracle users)
# - `db_startup`       (Make sure the database restarts after a reboot)
# 
# All these stages have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 
# 
# ## before classes
# 
# But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `limits` is done. You can do this by adding the next line to your yaml data:
# 
# ```yaml
# ora_profile::database::before_sysctl:   my_profile::my_extra_class
# ```
# 
# ## after classes
# 
# You can do the same when you want to add code after one of the stage classes:
# 
# ```yaml
# ora_profile::database::after_sysctl:   my_profile::my_extra_class
# ```
# 
# ## Skipping
# 
# Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:
# 
# ```yaml
# ora_profile::database::sysctl:   skip
# ```
# 
# ## Replacing
# 
# Or provide your own implementation:
# 
# ```yaml
# ora_profile::database::sysctl:   my_profile::my_own_implementation
# ```
# 
# This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.
# 
# Look at the description of the stages and their properties.
# 
# At this level you can also customize some generic settings. Check the settings for:
# 
# - `version`
# - `dbname`
# - `os_user`
# - `dba_group`
# - `install_group`
# - `source`
# - `oracle_base`
# - `oracle_home`
# 
# Here is an example on how you can do this:
# 
# ```puppet
# 
# class {'ora_profile::database':
#   dbname  => 'EM',
#   source  => 'http://www.example.com/database_files',
#   version => '11.2.0.3',
# }
# 
# ```
#
# @param [Ora_Install::Version] version
#    The version of Oracle you want to install.
#    The default is : `12.2.0.1`
#    To customize this consistently use the hiera key `ora_profile::database::version`.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#
# @param [String[1]] os_user
#    The OS user to use for Oracle install.
#    The default is : `oracle`
#    To customize this consistently use the hiera key `ora_profile::database::os_user`.
#
# @param [String[1]] dba_group
#    The group to use for Oracle DBA users.
#    The default is : `dba`
#    To customize this consistently use the hiera key `ora_profile::database::dba_group`.
#
# @param [String[1]] install_group
#    The group to use for Oracle install.
#    The default is : `oinstall`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] source
#    The location where the classes can find the software.
#    You can specify a local directory, a Puppet url or an http url.
#    The default is : `puppet:///modules/software/`
#    To customize this consistently use the hiera key `ora_profile::database::source`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [String[1]] grid_user
#    The name of the user that owns the Grid Infrastructure installation.
#    The default value is: `grid`.
#
# @param [String[1]] grid_admingroup
#    The OS group to use for ASM admin.
#    The default value is: `asmadmin`
#
# @param [Stdlib::Absolutepath] grid_base
#    The directory to use as grid base.
#    The default value is: `/u01/app/grid/admin`
#
# @param [Stdlib::Absolutepath] grid_home
#    The oracle home directory to use for the GRID software.
#    The default value is: `/u01/app/grid/product/12.2.0.1/grid_home1`
#
# @param [Optional[String]] sysctl
#    Use this value if you want to skip or use your own class for stage `sysctl`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::sysctl:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::sysctl:  skip
#    ```
#
# @param [Optional[String]] limits
#    Use this value if you want to skip or use your own class for stage `limits`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::limits:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::limits:  skip
#    ```
#
# @param [Optional[String]] packages
#    Use this value if you want to skip or use your own class for stage `packages`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::packages:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::packages:  skip
#    ```
#
# @param [Optional[String]] groups_and_users
#    Use this value if you want to skip or use your own class for stage `groups_and_users`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::groups_and_users:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::groups_and_users:  skip
#    ```
#
# @param [Optional[String]] firewall
#    Use this value if you want to skip or use your own class for stage `firewall`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::firewall:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::firewall:  skip
#    ```
#
# @param [Optional[String]] db_software
#    Use this value if you want to skip or use your own class for stage `db_software`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_software:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_software:  skip
#    ```
#
# @param [Optional[String]] db_patches
#    Use this value if you want to skip or use your own class for stage `db_patches`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_patches:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_patches:  skip
#    ```
#
# @param [Optional[String]] db_definition
#    Use this value if you want to skip or use your own class for stage `db_definition`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_definition:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_definition:  skip
#    ```
#
# @param [Optional[String]] db_listener
#    Use this value if you want to skip or use your own class for stage `db_listener`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_listener:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_listener:  skip
#    ```
#
# @param [Optional[String]] db_services
#    Use this value if you want to skip or use your own class for stage `db_services`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_services:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_services:  skip
#    ```
#
# @param [Optional[String]] db_tablespaces
#    Use this value if you want to skip or use your own class for stage `db_tablespaces`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_tablespaces:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_tablespaces:  skip
#    ```
#
# @param [Optional[String]] db_profiles
#    Use this value if you want to skip or use your own class for stage `db_profiles`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_profiles:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_profiles:  skip
#    ```
#
# @param [Optional[String]] db_users
#    Use this value if you want to skip or use your own class for stage `db_users`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_users:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_users:  skip
#    ```
#
# @param [Optional[String]] db_startup
#    Use this value if you want to skip or use your own class for stage `db_startup`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_startup:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_startup:  skip
#    ```
#
# @param [Optional[String]] before_sysctl
#    The name of the class you want to execute directly **before** the `sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_sysctl:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_limits
#    The name of the class you want to execute directly **before** the `limits` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_limits:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_packages
#    The name of the class you want to execute directly **before** the `packages` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_packages:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_groups_and_users
#    The name of the class you want to execute directly **before** the `groups_and_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_groups_and_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_firewall
#    The name of the class you want to execute directly **before** the `firewall` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_firewall:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_software
#    The name of the class you want to execute directly **before** the `db_software` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_software:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_patches
#    The name of the class you want to execute directly **before** the `db_patches` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_patches:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_definition
#    The name of the class you want to execute directly **before** the `limits` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_limits:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_listener
#    The name of the class you want to execute directly **before** the `db_listener` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_listener:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_services
#    The name of the class you want to execute directly **before** the `db_services` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_services:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_tablespaces
#    The name of the class you want to execute directly **before** the `db_tablespaces` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_tablespaces:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_profiles
#    The name of the class you want to execute directly **before** the `db_profiles` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_profiles:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_users
#    The name of the class you want to execute directly **before** the `db_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_startup
#    The name of the class you want to execute directly **before** the `db_startup` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_startup:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_sysctl
#    The name of the class you want to execute directly **after** the `sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_sysctl:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_limits
#    The name of the class you want to execute directly **after** the `limits` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_limits:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_packages
#    The name of the class you want to execute directly **after** the `packages` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_packages:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_groups_and_users
#    The name of the class you want to execute directly **after** the `groups_and_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_groups_and_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_firewall
#    The name of the class you want to execute directly **after** the `firewall` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_firewall:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_software
#    The name of the class you want to execute directly **after** the `db_software` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_software:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_patches
#    The name of the class you want to execute directly **after** the `db_patches` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_patches:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_definition
#    The name of the class you want to execute directly **after** the `db_definition` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_definition:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_listener
#    The name of the class you want to execute directly **after** the `db_listener` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_listener:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_services
#    The name of the class you want to execute directly **after** the `db_services` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_services:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_tablespaces
#    The name of the class you want to execute directly **after** the `db_tablespaces` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_tablespaces:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_profiles
#    The name of the class you want to execute directly **after** the `db_profiles` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_profiles:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_users
#    The name of the class you want to execute directly **after** the `db_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_startup
#    The name of the class you want to execute directly **after** the `db_startup` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_startup:  my_module::my_class
#    ```
#
# @param [String[1]] db_control_provider
#    Which provider should be used for the type db_control.
#    The default value is: `sqlplus`
#
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
  Optional[String] $master_node = $facts['hostname'],
  Optional[Array]  $cluster_nodes = undef,
  Optional[String] $asm_sysctl = undef,
  Optional[String] $asm_limits = undef,
  Optional[String] $authenticated_nodes = undef,
  Optional[String] $asm_groups_and_users = undef,
  Optional[String] $asm_packages = undef,
  Optional[String] $asm_listener = undef,
  Optional[String] $sysctl = undef,
  Optional[String] $limits = undef,
  Optional[String] $packages = undef,
  Optional[String] $groups_and_users = undef,
  Optional[String] $firewall = undef,
  Optional[String] $asm_storage = undef,
  Optional[String] $asm_software = undef,
  Optional[String] $asm_patches = undef,
  Optional[String] $asm_setup = undef,
  Optional[String] $asm_init_params = undef,
  Optional[String] $asm_diskgroup = undef,
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
  Optional[String] $before_asm_sysctl = undef,
  Optional[String] $before_asm_limits = undef,
  Optional[String] $before_authenticated_nodes = undef,
  Optional[String] $before_asm_groups_and_users = undef,
  Optional[String] $before_asm_packages = undef,
  Optional[String] $before_asm_listener = undef,
  Optional[String] $before_sysctl = undef,
  Optional[String] $before_limits = undef,
  Optional[String] $before_packages = undef,
  Optional[String] $before_groups_and_users = undef,
  Optional[String] $before_firewall = undef,
  Optional[String] $before_asm_storage = undef,
  Optional[String] $before_asm_software = undef,
  Optional[String] $before_asm_patches = undef,
  Optional[String] $before_asm_setup = undef,
  Optional[String] $before_asm_init_params = undef,
  Optional[String] $before_asm_diskgroup = undef,
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
  Optional[String] $after_asm_sysctl = undef,
  Optional[String] $after_asm_limits = undef,
  Optional[String] $after_authenticated_nodes = undef,
  Optional[String] $after_asm_groups_and_users = undef,
  Optional[String] $after_asm_packages = undef,
  Optional[String] $after_asm_listener = undef,
  Optional[String] $after_sysctl = undef,
  Optional[String] $after_limits = undef,
  Optional[String] $after_packages = undef,
  Optional[String] $after_groups_and_users = undef,
  Optional[String] $after_firewall = undef,
  Optional[String] $after_asm_storage = undef,
  Optional[String] $after_asm_software = undef,
  Optional[String] $after_asm_patches = undef,
  Optional[String] $after_asm_setup = undef,
  Optional[String] $after_asm_init_params = undef,
  Optional[String] $after_asm_diskgroup = undef,
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
  $asm_instance_name         = set_param('instance_name', '+ASM', $cluster_nodes)
  $db_instance_name          = set_param('instance_name', $dbname, $cluster_nodes)
  $instance_number           = set_param('instance_number', $dbname, $cluster_nodes)
  $thread_number             = set_param('instance_number', $dbname, $cluster_nodes)

  $is_linux                  = $::kernel == 'Linux'
  $is_windows                = $::kernel == 'Windows'
  $use_asm                   = $storage == 'asm'
  $is_rac                    = !empty($cluster_nodes)
  $asm_software_install_task = lookup('ora_profile::database::asm_software::install_task')
  $asm_inline_patch          = $use_asm and $asm_software_install_task != 'ALL'

  easy_type::staged_contain([
    ['ora_profile::database::sysctl',                   $is_linux],
    ['ora_profile::database::limits',                   $is_linux],
    ['ora_profile::database::groups_and_users',         !$use_asm],
    ['ora_profile::database::packages',                 $is_linux],
    ['ora_profile::database::firewall',                 $is_linux],
    ['ora_profile::database::asm_sysctl',               $use_asm],
    ['ora_profile::database::asm_limits',               $use_asm],
    ['ora_profile::database::asm_groups_and_users',     $use_asm],
    ['ora_profile::database::rac::authenticated_nodes', $is_rac],
    ['ora_profile::database::asm_packages',             $use_asm],
    ['ora_profile::database::asm_storage',              $use_asm],
    ['ora_profile::database::asm_software',             $use_asm],
    ['ora_profile::database::asm_patches',              $use_asm],
    ['ora_profile::database::asm_setup',                $asm_inline_patch],
    ['ora_profile::database::asm_init_params',          $use_asm],
    ['ora_profile::database::asm_diskgroup',            $use_asm],
    'ora_profile::database::db_software',
    'ora_profile::database::db_patches',
    'ora_profile::database::db_definition',
    ['ora_profile::database::db_listener',              !$use_asm],
    ['ora_profile::database::asm_listener',             $use_asm],
    'ora_profile::database::db_init_params',
    'ora_profile::database::db_services',
    'ora_profile::database::db_tablespaces',
    'ora_profile::database::db_profiles',
    'ora_profile::database::db_users',
    ['ora_profile::database::db_startup',             !$is_rac],
  ])
}
