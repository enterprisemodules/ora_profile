#++--++
#
# ora_profile::oem_agent::limits
#
# @summary This class contains the definition all the required OS limit settings for OEM Agent on your system.
#
#
# @param [Hash] list
#    The OS limits created for Oracle.
#    The defaults are:
#    ```yaml
#    ora_profile::oem_agent::limits::list:
#      '*/nproc':
#        soft: 4096
#        hard: 16384
#    ```
#
#--++--
class ora_profile::oem_agent::limits(
  Hash $list,
) {

  if $list.keys.size > 0 {
    echo {"Ensure OEM Agent Limit(s) ${list.keys.join(',')}":
      withpath => false,
    }
  }

  ensure_resources(limits::limits, $list)
}
