#
# ora_profile::database
#
# @summary This is a highly customizable Puppet profile class to define an Oracle database on your system.
# In it's core just adding:
# 
# ```
# contain ::ora_profile::database
# ```
# 
# Is enough to get an Oracle 19c database running on your system. 
# 
# But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.
# 
# ## Steps
# 
# Defining and starting an Oracle database on you system goes through several steps :
# 
# - `em_license`       (Enable and load the Enterprise Modules license files)
# - `fact_caching`     (Enable Puppet fact caching for Oracle)
# - `sysctl`           (Set all required sysctl parameters)
# - `disable_thp`      (Disable Transparent HugePages)
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
# All these steps have a default implementation. This implementation is suitable to get started with. These classed all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 
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
# This mechanism can be used for all named steps and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.
# 
# Look at the description of the steps and their properties.
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
# Also check the set of [common parameters](./common) that is passed to this class.
#
# @param [Enum['local', 'asm']] storage
#    The type of storage used.
#    The default is `local`
#
# @param [Ora_Install::Version] version
#    The version of Oracle you want to install.
#    The default is : `19.0.0.0`
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
# @param [String[1]] grid_user
#    The name of the user that owns the Grid Infrastructure installation.
#    The default value is: `grid`.
#
# @param [String[1]] grid_admingroup
#    The OS group to use for ASM admin.
#    The default value is: `asmadmin`
#
# @param [String[1]] source
#    The location where the classes can find the software.
#    You can specify a local directory, a Puppet url or an http url.
#    The default is : `puppet:///modules/software/`
#    To customize this consistently use the hiera key `ora_profile::database::source`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [Stdlib::Absolutepath] ora_inventory_dir
#    The directory that contains the oracle inventory.
#    The default value is: `/oracle_base/oraInventory`
#    To customize this consistently use the hiera key `ora_profile::database::ora_inventory_dir`.
#
# @param [Stdlib::Absolutepath] grid_base
#    The ORACLE_BASE for the Grid Infrastructure installation.
#    The default is : `/u01/app/grid/admin`
#    To customize this consistently use the hiera key `ora_profile::database::grid_base`.
#
# @param [Stdlib::Absolutepath] grid_home
#    The oracle home directory to use for the GRID software.
#    The default value is: `/u01/app/grid/product/19.0.0.0/grid_home1`
#
# @param [String[1]] db_control_provider
#    Which provider should be used for the type db_control.
#    The default value is: `sqlplus`
#    To customize this consistently use the hiera key `ora_profile::database::db_control_provider`.
#
# @param [Stdlib::Absolutepath] download_dir
#    The directory where the Puppet software puts all downloaded files.
#    Before Puppet can actually use remote files, they must be downloaded first. Puppet uses this directory to put all files in.
#    The default value is: `/install`
#    To customize this consistently use the hiera key `ora_profile::database::download_dir`.
#
# @param [Stdlib::Absolutepath] temp_dir
#    Directory to use for temporary files.
#
# @param [Optional[String]] oracle_user_password
#    The password for the oracle os user.
#    Only applicable for Windows systems.
#    To customize this consistently use the hiera key `ora_profile::database::oracle_user_password`.
#
# @param [Optional[String]] master_node
#    The first node in RAC.
#    This  is the node where the other nodes will clone the software installations from.
#    To customize this consistently use the hiera key `ora_profile::database::master_node`.
#
# @param [Optional[Array]] cluster_nodes
#    An array with cluster node names for RAC.
#    Example:
#    ```yaml
#    ora_profile::database::cluster_nodes:
#    - node1
#    - node2
#    ```
#
# @param [Optional[String]] em_license
#    Use this value if you want to skip or use your own class for stage `em_license`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::em_license:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::em_license:  skip
#    ```
#
# @param [Optional[String]] fact_caching
#    Use this value if you want to skip or use your own class for stage `fact_caching`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::fact_caching:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::fact_caching:  skip
#    ```
#
# @param [Optional[String]] asm_sysctl
#    Use this value if you want to skip or use your own class for stage `asm_sysctl`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_sysctl:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_sysctl:  skip
#    ```
#
# @param [Optional[String]] asm_limits
#    Use this value if you want to skip or use your own class for stage `asm_limits`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_limits:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_limits:  skip
#    ```
#
# @param [Optional[String]] authenticated_nodes
#    Use this value if you want to skip or use your own class for stage `authenticated_nodes`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::authenticated_nodes:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::authenticated_nodes:  skip
#    ```
#
# @param [Optional[String]] asm_groups_and_users
#    Use this value if you want to skip or use your own class for stage `asm_groups_and_users`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_groups_and_users:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_groups_and_users:  skip
#    ```
#
# @param [Optional[String]] asm_packages
#    Use this value if you want to skip or use your own class for stage `asm_packages`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_packages:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_packages:  skip
#    ```
#
# @param [Optional[String]] asm_listener
#    Use this value if you want to skip or use your own class for stage `asm_listener`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_listener:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_listener:  skip
#    ```
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
# @param [Optional[String]] disable_thp
#    Use this value if you want to skip or use your own class for stage `disable_thp`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::disable_thp:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::disable_thp:  skip
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
# @param [Optional[String]] tmpfiles
#    Use this value if you want to skip or use your own class for stage `tmpfiles`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::tmpfiles:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::tmpfiles:  skip
#    ```
#
# @param [Optional[String]] asm_storage
#    Use this value if you want to skip or use your own class for stage `asm_storage`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_storage:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_storage:  skip
#    ```
#
# @param [Optional[String]] asm_software
#    Use this value if you want to skip or use your own class for stage `asm_software`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_software:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_software:  skip
#    ```
#
# @param [Optional[String]] asm_patches
#    Use this value if you want to skip or use your own class for stage `asm_patches`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_patches:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_patches:  skip
#    ```
#
# @param [Optional[String]] asm_setup
#    Use this value if you want to skip or use your own class for stage `asm_setup`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_setup:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_setup:  skip
#    ```
#
# @param [Optional[String]] asm_init_params
#    Use this value if you want to skip or use your own class for stage `asm_init_params`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_init_params:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_init_params:  skip
#    ```
#
# @param [Optional[String]] asm_diskgroup
#    Use this value if you want to skip or use your own class for stage `asm_diskgroup`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_diskgroup:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::asm_diskgroup:  skip
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
# @param [Optional[String]] rman_config
#    Use this value if you want to use your own class, skip or enable for stage `rman_config`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::rman_config:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::rman_config:  skip
#    ```
#    This is the default from the ora_profile module.
#    To enable the rman configuration class define the variable as `undef`:
#    ```yaml
#    ora_profile::database::rman_config:  ~
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
# @param [Optional[String]] db_monitoring
#    Use this value if you want to skip or use your own class for stage `db_monitoring`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_monitoring:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_monitoring:  skip
#    ```
#
# @param [Optional[String]] db_init_params
#    Use this value if you want to skip or use your own class for stage `db_init_params`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_init_params:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::db_init_params:  skip
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
# @param [Optional[String]] before_em_license
#    The name of the class you want to execute directly **before** the `em_license` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_em_license:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_fact_caching
#    The name of the class you want to execute directly **before** the `fact_caching` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_fact_caching:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_sysctl
#    The name of the class you want to execute directly **before** the `asm_sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_sysctl:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_limits
#    The name of the class you want to execute directly **before** the `asm_limits` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_limits:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_authenticated_nodes
#    The name of the class you want to execute directly **before** the `authenticated_nodes` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_authenticated_nodes:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_groups_and_users
#    The name of the class you want to execute directly **before** the `asm_groups_and_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_groups_and_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_packages
#    The name of the class you want to execute directly **before** the `asm_packages` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_packages:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_listener
#    The name of the class you want to execute directly **before** the `asm_listener` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_listener:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_sysctl
#    The name of the class you want to execute directly **before** the `sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_sysctl:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_disable_thp
#    The name of the class you want to execute directly **before** the `disable_thp` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_disable_thp:  my_module::my_class
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
# @param [Optional[String]] before_tmpfiles
#    The name of the class you want to execute directly **before** the `tmpfiles` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_tmpfiles:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_storage
#    The name of the class you want to execute directly **before** the `asm_storage` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_storage:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_software
#    The name of the class you want to execute directly **before** the `asm_software` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_software:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_patches
#    The name of the class you want to execute directly **before** the `asm_patches` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_patches:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_setup
#    The name of the class you want to execute directly **before** the `asm_setup` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_setup:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_init_params
#    The name of the class you want to execute directly **before** the `asm_init_params` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_init_params:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_asm_diskgroup
#    The name of the class you want to execute directly **before** the `asm_diskgroup` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_asm_diskgroup:  my_module::my_class
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
#    The name of the class you want to execute directly **before** the `db_definition` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_definition:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_rman_config
#    The name of the class you want to execute directly **before** the `rman_config` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_rman_config:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_listener
#    The name of the class you want to execute directly **before** the `db_listener` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_listener:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_monitoring
#    The name of the class you want to execute directly **before** the `db_monitoring` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_monitoring:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_db_init_params
#    The name of the class you want to execute directly **before** the `db_init_params` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_db_init_params:  my_module::my_class
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
# @param [Optional[String]] after_em_license
#    The name of the class you want to execute directly **after** the `em_license` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_em_license:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_fact_caching
#    The name of the class you want to execute directly **after** the `fact_caching` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_fact_caching:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_sysctl
#    The name of the class you want to execute directly **after** the `asm_sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_sysctl:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_limits
#    The name of the class you want to execute directly **after** the `asm_limits` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_limits:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_authenticated_nodes
#    The name of the class you want to execute directly **after** the `authenticated_nodes` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_authenticated_nodes:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_groups_and_users
#    The name of the class you want to execute directly **after** the `asm_groups_and_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_groups_and_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_packages
#    The name of the class you want to execute directly **after** the `asm_packages` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_packages:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_listener
#    The name of the class you want to execute directly **after** the `asm_listener` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_listener:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_sysctl
#    The name of the class you want to execute directly **after** the `sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_sysctl:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_disable_thp
#    The name of the class you want to execute directly **after** the `disable_thp` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_disable_thp:  my_module::my_class
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
# @param [Optional[String]] after_tmpfiles
#    The name of the class you want to execute directly **after** the `tmpfiles` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_tmpfiles:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_storage
#    The name of the class you want to execute directly **after** the `asm_storage` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_storage:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_software
#    The name of the class you want to execute directly **after** the `asm_software` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_software:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_patches
#    The name of the class you want to execute directly **after** the `asm_patches` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_patches:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_setup
#    The name of the class you want to execute directly **after** the `asm_setup` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_setup:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_init_params
#    The name of the class you want to execute directly **after** the `asm_init_params` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_init_params:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_asm_diskgroup
#    The name of the class you want to execute directly **after** the `asm_diskgroup` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_asm_diskgroup:  my_module::my_class
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
# @param [Optional[String]] after_rman_config
#    The name of the class you want to execute directly **after** the `rman_config` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_rman_config:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_listener
#    The name of the class you want to execute directly **after** the `db_listener` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_listener:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_monitoring
#    The name of the class you want to execute directly **after** the `db_monitoring` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_monitoring:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_db_init_params
#    The name of the class you want to execute directly **after** the `db_init_params` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_db_init_params:  my_module::my_class
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
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database (
# lint:ignore:strict_indent
  String[1] $db_control_provider,
  String[1] $dba_group,
  String[1] $dbname,
  Stdlib::Absolutepath
            $download_dir,
  String[1] $grid_admingroup,
  Stdlib::Absolutepath
            $grid_base,
  Stdlib::Absolutepath
            $grid_home,
  String[1] $grid_user,
  String[1] $install_group,
  Stdlib::Absolutepath
            $ora_inventory_dir,
  Stdlib::Absolutepath
            $oracle_base,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $os_user,
  String[1] $source,
  Enum['local', 'asm']  $storage,
  Stdlib::Absolutepath
            $temp_dir,
  Ora_Install::Version $version,
  Optional[String] $after_asm_diskgroup        = undef,
  Optional[String] $after_asm_groups_and_users = undef,
  Optional[String] $after_asm_init_params      = undef,
  Optional[String] $after_asm_limits           = undef,
  Optional[String] $after_asm_listener         = undef,
  Optional[String] $after_asm_packages         = undef,
  Optional[String] $after_asm_patches          = undef,
  Optional[String] $after_asm_setup            = undef,
  Optional[String] $after_asm_software         = undef,
  Optional[String] $after_asm_storage          = undef,
  Optional[String] $after_asm_sysctl           = undef,
  Optional[String] $after_authenticated_nodes  = undef,
  Optional[String] $after_db_definition        = undef,
  Optional[String] $after_db_init_params       = undef,
  Optional[String] $after_db_listener          = undef,
  Optional[String] $after_db_monitoring        = undef,
  Optional[String] $after_db_patches           = undef,
  Optional[String] $after_db_profiles          = undef,
  Optional[String] $after_db_services          = undef,
  Optional[String] $after_db_software          = undef,
  Optional[String] $after_db_startup           = undef,
  Optional[String] $after_db_tablespaces       = undef,
  Optional[String] $after_db_users             = undef,
  Optional[String] $after_disable_thp          = undef,
  Optional[String] $after_em_license           = undef,
  Optional[String] $after_fact_caching         = undef,
  Optional[String] $after_firewall             = undef,
  Optional[String] $after_groups_and_users     = undef,
  Optional[String] $after_limits               = undef,
  Optional[String] $after_packages             = undef,
  Optional[String] $after_rman_config          = undef,
  Optional[String] $after_sysctl               = undef,
  Optional[String] $after_tmpfiles             = undef,
  Optional[String] $asm_diskgroup              = undef,
  Optional[String] $asm_groups_and_users       = undef,
  Optional[String] $asm_init_params            = undef,
  Optional[String] $asm_limits                 = undef,
  Optional[String] $asm_listener               = undef,
  Optional[String] $asm_packages               = undef,
  Optional[String] $asm_patches                = undef,
  Optional[String] $asm_setup                  = undef,
  Optional[String] $asm_software               = undef,
  Optional[String] $asm_storage                = undef,
  Optional[String] $asm_sysctl                 = undef,
  Optional[String] $authenticated_nodes        = undef,
  Optional[String] $before_asm_diskgroup       = undef,
  Optional[String] $before_asm_groups_and_users= undef,
  Optional[String] $before_asm_init_params     = undef,
  Optional[String] $before_asm_limits          = undef,
  Optional[String] $before_asm_listener        = undef,
  Optional[String] $before_asm_packages        = undef,
  Optional[String] $before_asm_patches         = undef,
  Optional[String] $before_asm_setup           = undef,
  Optional[String] $before_asm_software        = undef,
  Optional[String] $before_asm_storage         = undef,
  Optional[String] $before_asm_sysctl          = undef,
  Optional[String] $before_authenticated_nodes = undef,
  Optional[String] $before_db_definition       = undef,
  Optional[String] $before_db_init_params      = undef,
  Optional[String] $before_db_listener         = undef,
  Optional[String] $before_db_monitoring       = undef,
  Optional[String] $before_db_patches          = undef,
  Optional[String] $before_db_profiles         = undef,
  Optional[String] $before_db_services         = undef,
  Optional[String] $before_db_software         = undef,
  Optional[String] $before_db_startup          = undef,
  Optional[String] $before_db_tablespaces      = undef,
  Optional[String] $before_db_users            = undef,
  Optional[String] $before_disable_thp         = undef,
  Optional[String] $before_em_license          = undef,
  Optional[String] $before_fact_caching        = undef,
  Optional[String] $before_firewall            = undef,
  Optional[String] $before_groups_and_users    = undef,
  Optional[String] $before_limits              = undef,
  Optional[String] $before_packages            = undef,
  Optional[String] $before_rman_config         = undef,
  Optional[String] $before_sysctl              = undef,
  Optional[String] $before_tmpfiles            = undef,
  Optional[Array]  $cluster_nodes              = undef,
  Optional[String] $db_definition              = undef,
  Optional[String] $db_init_params             = undef,
  Optional[String] $db_listener                = undef,
  Optional[String] $db_monitoring              = undef,
  Optional[String] $db_patches                 = undef,
  Optional[String] $db_profiles                = undef,
  Optional[String] $db_services                = undef,
  Optional[String] $db_software                = undef,
  Optional[String] $db_startup                 = undef,
  Optional[String] $db_tablespaces             = undef,
  Optional[String] $db_users                   = undef,
  Optional[String] $disable_thp                = undef,
  Optional[String] $em_license                 = undef,
  Optional[String] $fact_caching               = undef,
  Optional[String] $firewall                   = undef,
  Optional[String] $groups_and_users           = undef,
  Optional[String] $limits                     = undef,
  Optional[String] $master_node                = $facts['networking']['hostname'],
  Optional[String] $oracle_user_password       = undef,
  Optional[String] $packages                   = undef,
  Optional[String] $rman_config                = undef,
  Optional[String] $sysctl                     = undef,
  Optional[String] $tmpfiles                   = undef
) {
# lint:endignore:strict_indent

  $asm_instance_name         = set_param('instance_name', '+ASM', $cluster_nodes)
  $db_instance_name          = set_param('instance_name', $dbname, $cluster_nodes)
  $instance_number           = set_param('instance_number', $dbname, $cluster_nodes)
  $thread_number             = set_param('instance_number', $dbname, $cluster_nodes)

  $is_linux                  = $facts['kernel'] == 'Linux'
  $is_windows                = $facts['kernel'] == 'Windows'
  $use_asm                   = $storage == 'asm'
  $is_rac                    = !empty($cluster_nodes)
  $asm_software_install_task = lookup('ora_profile::database::asm_software::install_task')
  $asm_inline_patch          = $use_asm and $asm_software_install_task != 'ALL'

  easy_type::debug_evaluation() # Show local variable on extended debug

  easy_type::ordered_steps([
      'ora_profile::database::em_license',
      'ora_profile::database::fact_caching',
      ['ora_profile::database::sysctl', { 'onlyif' => $is_linux, 'implementation' => 'easy_type::profile::sysctl' }],
      ['ora_profile::database::disable_thp', { 'onlyif' => $is_linux }],
      ['ora_profile::database::limits', { 'onlyif' => $is_linux, 'implementation' => 'easy_type::profile::limits' }],
      ['ora_profile::database::groups_and_users', { 'onlyif' => !$use_asm, 'implementation' => 'easy_type::profile::groups_and_users' }],
      ['ora_profile::database::packages', { 'implementation' => 'easy_type::profile::packages' }],
      #
      # Although there is an easy_type::profile::firewall implementation, it doesn't fit here. We are doing more here
      #
      ['ora_profile::database::firewall', { 'onlyif' => $is_linux }],
      ['ora_profile::database::tmpfiles', { 'onlyif' => $is_linux }],
      ['ora_profile::database::asm_sysctl', { 'onlyif' => $use_asm, 'implementation' => 'easy_type::profile::sysctl' }],
      ['ora_profile::database::asm_limits', { 'onlyif' => $use_asm, 'implementation' => 'easy_type::profile::limits' }],
      ['ora_profile::database::asm_groups_and_users', { 'onlyif' => $use_asm, 'implementation' => 'easy_type::profile::groups_and_users' }],
      ['ora_profile::database::rac::authenticated_nodes', { 'onlyif' => $is_rac }],
      ['ora_profile::database::asm_packages', { 'onlyif' => $use_asm, 'implementation' => 'easy_type::profile::packages' }],
      ['ora_profile::database::asm_storage', { 'onlyif' => $use_asm }],
      ['ora_profile::database::asm_software', { 'onlyif' => $use_asm }],
      ['ora_profile::database::asm_patches', { 'onlyif' => $use_asm }],
      ['ora_profile::database::asm_setup', { 'onlyif' => $asm_inline_patch }],
      ['ora_profile::database::asm_init_params', { 'onlyif' => $use_asm }],
      ['ora_profile::database::asm_diskgroup', { 'onlyif' => $use_asm }],
      'ora_profile::database::db_software',
      'ora_profile::database::db_patches',
      'ora_profile::database::db_definition',
      'ora_profile::database::rman_config',
      ['ora_profile::database::db_listener', { 'onlyif' => !$use_asm }],
      ['ora_profile::database::asm_listener', { 'onlyif' => $use_asm }],
      'ora_profile::database::db_init_params',
      'ora_profile::database::db_services',
      'ora_profile::database::db_tablespaces',
      'ora_profile::database::db_profiles',
      'ora_profile::database::db_users',
      ['ora_profile::database::db_startup', { 'onlyif' => !$is_rac }],
      'ora_profile::database::db_monitoring',
  ])
}
