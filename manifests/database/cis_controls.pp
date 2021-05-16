#++--++
#
# ora_profile::database::cis_controls
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
# @param [Optional[String[1]]] product_version
#    The database version of the CIS benchmark you want to apply.
#    Although not very logical, you **can** apply an older (or newer) database version to your database.
#    If you also don't specify a `db_version`, Puppet will detect the version of Oracle running and use this to determine the `db_version`. There is, however, one issue with the detection. On an initial run Puppet canot determine what the Oracle version is. In that case, the ora_secured::ensure_cis defined type will skip applying the CIS benchmark and wait until (hopefully) the next run the version of Oracle for specified sid is available.
#
# @param [Optional[String[1]]] doc_version
#    The version of the CIS benchmark you want to apply to your database.
#    When you don't specify the `doc_version`, puppet automatically uses the latest version for your current `product_version`.
#
# @param [Optional[Array[String[1]]]] skip_list
#    This is the list of controls that you want to skip.
#    By default this value is empty, meaning `ora_secured::ensure_cis` will apply **ALL** controls. You must specify the name of the control.
#
#--++--
class ora_profile::database::cis_controls(
  String[1]                   $dbname,
  Optional[String[1]]         $product_version,
  Optional[String[1]]         $doc_version,
  Optional[Array[String[1]]]  $skip_list,
) inherits ora_profile::database {

  easy_type::debug_evaluation() # Show local variable on extended debug

  echo {"Making sure database ${dbname} is secured.":
    withpath => false,
  }

  ora_secured::ensure_cis { $dbname:
    product_version => $product_version,
    doc_version     => $doc_version,
    skip_list       => $skip_list,
  }
}
