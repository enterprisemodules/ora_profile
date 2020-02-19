#++--++
#
# ora_profile::database::em_license
#
#
#--++--
class ora_profile::database::em_license
{
  include stdlib

  unless defined(Class['easy_type::license::available']) {
    class{'::easy_type::license::available':
      stage => 'setup',
    }
  }
}
