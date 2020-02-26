#++--++
#
# ora_profile::database::cis_rules
#
# @summary This class contains the actual code secureing the database.
# Here you ca customise the securtiy by specifying the CIS rules you *don't* want to apply.
# 
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::secured_database](./secured_database.html) for an explanation on how to do this.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#
# @param [Array[String[1]]] ignore
#    Name the CIS rules you don't want to apply (e.
#    g. ignore) to your database.
#    An example:
#    ```yaml
#    ora_profile::database::cis_rules::ignore:
#      - r_1_1
#      ...
#      - r_2_1_4
#    ```
#    The default is:
#    ```yaml
#      - r_1_1
#      - r_2_1_1
#      - r_2_1_2
#      - r_2_1_3
#      - r_2_1_4
#    ```
#    These are actualy the rules that don't secure anything *inside* of a database.
#
#--++--
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
