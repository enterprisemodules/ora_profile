# ora_profile::database::db_profiles
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::db_profiles
class ora_profile::database::db_profiles(
  Hash $list
) {
  echo {'DB profiles':}
  #
  # This is a simple way to get started. It is easy to get started, but
  # soon your hiera yaml become a nigtmare. Our advise is when you need
  # to let puppet manage your Oracle profiles, to override this class and 
  # add your own puppet implementation. This is much better maintainable
  # and adds more consistency,
  #
  create_resources(ora_profile, $list)
}
