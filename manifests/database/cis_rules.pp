# ora_profile::database::cis_rules
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::cis_rules
class ora_profile::database::cis_rules(
  String[1]         $dbname,
  Array[String[1]]  $ignore,
) inherits ora_profile::database {
  echo {"Making sure database ${dbname} is secured.":
    withpath => false,
  }

  ora_cis { $dbname:
    ignore => $ignore,
  }
}
