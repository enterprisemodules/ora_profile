#++--++
#
# ora_profile::oem_server
#
# @summary This is a highly customizable Puppet profile class to define an Oracle Enterprise Manager installation on your system.
# In it's core just adding:
# 
# ```
# contain ::ora_profile::oem_server
# ```
# 
# Is enough to get Oracle Enterprise Manager installed on your system. 
# 
# But sometimes you have specific uses cases that are not handled well by the standard classes. This profile class allows you to add your own code to the execution.
# 
# ## Stages
# 
# Defining and starting an Oracle Enterprise Manager installation on you system goes through several stages(These are not puppet stages):
# 
# - `em_license`         (Deploy Enterprise Modules license)
# - `sysctl`             (Set all required sysctl parameters)
# - `groups_and_users`   (Create required groups and users)
# - `firewall`           (Open required firewall rules)
# - `limits`             (Set all required OS limits)
# - `packages`           (Install all required packages)
# - `software`           (Install the Oracle Enterprise Manager software)
# 
# All these stages have a default implementation. This implementation is suitable to get started with. These classes all have parameters you can customize through hiera values. The defaults are specified in the module's `data/default.yaml` file. 
# 
# ## before classes
# 
# But sometimes this is not enough and you would like to add some extra definitions, you can, for example, add a Puppet class to be executed after the `systctl` stage is done and before the `groups_and_users` is started. You can do this by adding the next line to your yaml data:
# 
# ```yaml
# ora_profile::oem_server::before_groups_and_users:   my_profile::my_extra_class
# ```
# 
# ## after classes
# 
# You can do the same when you want to add code after one of the stage classes:
# 
# ```yaml
# ora_profile::oem_server::after_groups_and_users:   my_profile::my_extra_class
# ```
# 
# ## Skipping
# 
# Sometimes organisation use different modules and mechanisms to implement a feature and you want to skip the class:
# 
# ```yaml
# ora_profile::oem_server::packages:   skip
# ```
# 
# ## Replacing
# 
# Or provide your own implementation:
# 
# ```yaml
# ora_profile::oem_server::packages:   my_profile::my_own_implementation
# ```
# 
# This mechanism can be used for all named stages and makes it easy to move from an easy setup with a running standard database to a fully customized setup using a lot of your own classes plugged in.
# 
# Here is an example:
# ```puppet
# contain ::ora_profile::oem_server
# ```
#
# @param [Optional[String]] after_em_license
#    The name of the class you want to execute directly **after** the `em_license` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_em_license:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_firewall
#    The name of the class you want to execute directly **after** the `firewall` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_firewall:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_groups_and_users
#    The name of the class you want to execute directly **after** the `groups_and_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_groups_and_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_limits
#    The name of the class you want to execute directly **after** the `limits` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::after_limits:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_packages
#    The name of the class you want to execute directly **after** the `packages` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::after_packages:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_software
#    The name of the class you want to execute directly **after** the `software` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::after_software:  my_module::my_class
#    ```
#
# @param [Optional[String]] after_sysctl
#    The name of the class you want to execute directly **after** the `sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::after_sysctl:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_em_license
#    The name of the class you want to execute directly **before** the `em_license` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_em_license:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_firewall
#    The name of the class you want to execute directly **before** the `firewall` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_firewall:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_groups_and_users
#    The name of the class you want to execute directly **before** the `groups_and_users` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_groups_and_users:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_limits
#    The name of the class you want to execute directly **before** the `limits` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::before_limits:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_packages
#    The name of the class you want to execute directly **before** the `packages` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::before_packages:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_software
#    The name of the class you want to execute directly **before** the `software` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::before_software:  my_module::my_class
#    ```
#
# @param [Optional[String]] before_sysctl
#    The name of the class you want to execute directly **before** the `sysctl` class.
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::database::before_sysctl:  my_module::my_class
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
# @param [Optional[String]] limits
#    Use this value if you want to skip or use your own class for stage `limits`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::limits:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::limits:  skip
#    ```
#
# @param [Optional[String]] packages
#    Use this value if you want to skip or use your own class for stage `packages`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::packages:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::packages:  skip
#    ```
#
# @param [Optional[String]] software
#    Use this value if you want to skip or use your own class for stage `software`.
#    ## Use your own class
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::software:  my_module::my_class
#    ```
#    ## Skip
#    You can use hiera to set this value. Here is an example:
#    ```yaml
#    ora_profile::oem_server::software:  skip
#    ```
#
# @param [Optional[Boolean]] standalone
#    Indicate if this is a standalone (Only install OEM) or not (Install database and OEM)
#    Valid values are `true` and `false`.
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
#--++--
class ora_profile::oem_server(
  Optional[Boolean] $standalone              = undef,
  Optional[String]  $before_em_license       = undef,
  Optional[String]  $em_license              = undef,
  Optional[String]  $after_em_license        = undef,
  Optional[String]  $before_sysctl           = undef,
  Optional[String]  $sysctl                  = undef,
  Optional[String]  $after_sysctl            = undef,
  Optional[String]  $before_groups_and_users = undef,
  Optional[String]  $groups_and_users        = undef,
  Optional[String]  $after_groups_and_users  = undef,
  Optional[String]  $before_firewall         = undef,
  Optional[String]  $firewall                = undef,
  Optional[String]  $after_firewall          = undef,
  Optional[String]  $before_limits           = undef,
  Optional[String]  $limits                  = undef,
  Optional[String]  $after_limits            = undef,
  Optional[String]  $before_packages         = undef,
  Optional[String]  $packages                = undef,
  Optional[String]  $after_packages          = undef,
  Optional[String]  $before_software         = undef,
  Optional[String]  $software                = undef,
  Optional[String]  $after_software          = undef,
)
{
  unless ( $standalone ) {
    contain ::ora_profile::database

    Class['ora_profile::database']
    -> Class['ora_profile::oem_server::limits']
  }

  easy_type::debug_evaluation() # Show local variable on extended debug

  easy_type::staged_contain([
    ['ora_profile::database::em_license',       { 'onlyif' => $standalone }],
    ['ora_profile::database::sysctl',           { 'onlyif' => $standalone, 'implementation' => 'easy_type::profile::sysctl' }],
    ['ora_profile::database::groups_and_users', { 'onlyif' => $standalone, 'implementation' => 'easy_type::profile::sysctl' }],
    ['ora_profile::database::firewall',         { 'onlyif' => $standalone }],
    ['ora_profile::oem_server::limits',         { 'implementation' => 'easy_type::profile::limits' }],
    ['ora_profile::oem_server::packages',       { 'implementation' => 'easy_type::profile::packages' }],
    'ora_profile::oem_server::software',
  ])
}
