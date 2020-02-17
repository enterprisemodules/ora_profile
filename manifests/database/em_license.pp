#++--++
#
# ora_profile::database::em_license
#
#
#--++--
class ora_profile::database::em_license
{
  unless defined('easy_type::license::available') {
    class{'::easy_type::license::available':
      stage => 'setup',
    }
  }
}
