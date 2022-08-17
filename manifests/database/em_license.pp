#
# ora_profile::database::em_license
#
# @summary This class will deploy the Enterprise Modules license.
#
#
#
# See the file "LICENSE" for the full license governing this code.
#
class ora_profile::database::em_license {
  unless defined(Class['easy_type::license::activate']) {
    debug 'License activated in ora_profile'
    contain easy_type::license::activate
  }
}
