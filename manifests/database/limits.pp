# ora_profile::database::limits
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::limits
class ora_profile::database::limits(
  Hash $list
) inherits ora_profile::database {
  echo {'Limits':}
  create_resources(limits::limits, $list)
}
