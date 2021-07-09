#++--++
#
# ora_profile::database::asm_init_params
#
# @summary This class configures initialization parameters for the ASM instance
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Hash] parameters
#    The Hash with parameters that need to be configured.
#    You must specify a Hash of [ora_init_param](/docs/ora_config/ora_init_param.html)
#    ```yaml
#    ora_profile::database::asm_init_params::parameters:
#      memory/asm_power_limit:
#        ensure: present
#        value: 1024
#      spfile/asm_power_limit:
#        ensure: present
#        value: 1024
#    ```
#    ```yaml
#    ora_profile::database::db_init_params::parameters:
#      memory/archive_lag_target:
#        ensure: present
#        value: 1800
#      spfile/archive_lag_target:
#        ensure: present
#        value: 1800
#    ```
#    See: [ora_init_params](https://www.enterprisemodules.com/docs/ora_config/ora_init_param.html)
#
#--++--
class ora_profile::database::asm_init_params(
  Hash    $parameters         = {},
) inherits ora_profile::database {
# lint:ignore:variable_scope

  easy_type::debug_evaluation() # Show local variable on extended debug

  if $parameters.keys.size > 0 {
    echo {"Ensure ASM init parameter(s) ${parameters.keys.join(',')}":
      withpath => false,
    }
  }

  $parameters.each |String $param, Hash $param_props = {}| {
    if $param =~ '@' {
      $init_param = $param
    } else {
      $init_param = "${param}@${asm_instance_name}"
    }
    ora_init_param {
      default:
        ensure => present,
      ;
      $init_param:
        * => $param_props,
    }
  }

}
# lint:endignore
