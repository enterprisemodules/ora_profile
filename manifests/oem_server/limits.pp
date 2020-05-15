#++--++
#
# ora_profile::oem_server::limits
#
# @summary This class contains the definition all the required OS limit settings for OEM Server on your system.
#
#
# @param [Hash] list
#    The OS limits created for Oracle.
#    The defaults are:
#    ```yaml
#    ora_profile::oem_server::limits::list:
#      '*/nproc':
#        soft: 4098
#        hard: 8192
#    ```
#
#--++--
class ora_profile::oem_server::limits(
  Hash $list,
) {

  if $list.keys.size > 0 {
    echo {"Ensure OEM Limit(s) ${list.keys.join(',')}":
      withpath => false,
    }
  }

  ensure_resources(limits::limits, $list)
}
