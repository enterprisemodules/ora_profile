#
# ora_profile::database::fact_caching
#
# @summary This class will enable Oracle fact caching, when enabled.
#
#
# @param [Boolean] enabled
#    Boolean to determine if you want to enabled Puppet fact caching for the Oracle facts.
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::fact_caching (
  Boolean $enabled,
) {
  if defined('ora_config::fact_caching') {
    class { 'ora_config::fact_caching':  enabled => $enabled }
  }
  if defined('ora_install::fact_caching') {
    class { 'ora_install::fact_caching': enabled => $enabled }
  }
}
