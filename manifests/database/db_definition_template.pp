#++--++
#
# ora_profile::db_definition_template
#
# @summary This class contains the actual database definition using the `ora_install::database` class.
# In this class the database will be created from a template. When using a 'seed' template, this will significantly decrease the time it takes to create a database. Bij default the Oracle supplied General_Purpose template is used, which is probably not the best option for your production environment.
# This class is meant to replace the db_definition class by specifying in your yaml file:
# 
# ```yaml
# ora_profile::database::before_sysctl:  my_module::my_class
# ```
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Enum['12.2.0.1', '12.1.0.1', '12.1.0.2', '11.2.0.3', '11.2.0.4', '11.2.0.1']] version
#    The version of Oracle you want to install.
#    The default is : `12.2.0.1`
#    To customize this consistently use the hiera key `ora_profile::database::version`.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base firectory to use for the Oracle installation.
#    The default is : `/u01/app/oracle`
#    To customize this consistently use the hiera key `ora_profile::database::install_group`.
#
# @param [String[1]] dbname
#    The name of the database.
#    The default is `DB01`
#    To customize this consistently use the hiera key `ora_profile::database::dbname`.
#
# @param [String[1]] template_name
#    The name of the template to use for creating the database
#    The default value is `General_Purpose.${version}`
#
# @param [Enum['non-seed', 'seed']] template_type
#    What type of template is used for creating the database.
#    The default value is `seed`
#
# @param [String[1]] data_file_destination
#    The location where you want to store your database files.
#    A filesystem or ASM location can be specified.
#    The default value is `+DATA`
#
# @param [String[1]] recovery_area_destination
#    The location where you want to store your flash recovery area.
#    A filesystem or ASM location can be specified.
#    The default value is `+RECO`
#
# @param [Enum['TRUE', 'FALSE']] sample_schema
#    Specify if you want the sample schemas installed in your database.
#    The default value is `FALSE`
#
# @param [Enum['AUTO', 'AUTO_SGA', 'CUSTOM_SGA']] memory_mgmt_type
#    How the database memory should be managed.
#    The default value is `AUTO_SGA`
#
# @param [Enum['FS', 'CFS', 'ASM']] storage_type
#    What type of storage is used for your database.
#    The default value is `ASM`
#
# @param [String[1]] puppet_download_mnt_point
#    Where to get the source of your template from.
#    This is the module where the xml file for your template is stored as a puppet template(erb).
#    The default value is `ora_profile`
#
# @param [String[1]] system_password
#    The `system` password to use for the database.
#    The default value is: `Welcome01`
#
# @param [String[1]] sys_password
#    The `sys` password to use for the database.
#    The default value is: `Change_on_1nstall`
#
# @param [Optional[String[1]]] cluster_nodes
#    A comma seperated list of nodes in your cluster, for RAC databases.
#    The default value is `undef`
#
#--++--
class ora_profile::database::db_definition_template(
  Enum['12.2.0.1','12.1.0.1','12.1.0.2','11.2.0.3','11.2.0.4', '11.2.0.1']
                      $version,
  Stdlib::Absolutepath
                      $oracle_home,
  Stdlib::Absolutepath
                      $oracle_base,
  String[1]           $dbname,
  String[1]           $template_name,
  Enum['non-seed','seed']
                      $template_type,
  String[1]           $data_file_destination,
  String[1]           $recovery_area_destination,
  Enum['TRUE','FALSE']
                      $sample_schema,
  Enum['AUTO','AUTO_SGA','CUSTOM_SGA']
                      $memory_mgmt_type,
  Enum['FS','CFS','ASM']
                      $storage_type,
  String[1]           $puppet_download_mnt_point,
  String[1]           $system_password,
  String[1]           $sys_password,
  Enum['SINGLE','RAC','RACONE']
                      $db_conf_type,
  Optional[String[1]] $cluster_nodes,
) inherits ora_profile::database {

  echo {"Ensure DB definition from template for database ${dbname} in ${oracle_home}":
    withpath => false,
  }
  #
  # All standard values fetched in data function
  #
  $split_version = split($version, '[.]')
  $db_version = "${split_version[0]}.${split_version[1]}"

  ora_install::database{ $dbname:
    action                    => 'create',
    oracle_base               => $oracle_base,
    oracle_home               => $oracle_home,
    version                   => $db_version,
    template                  => $template_name,
    template_type             => $template_type,
    db_name                   => $dbname,
    data_file_destination     => $data_file_destination,
    recovery_area_destination => $recovery_area_destination,
    sample_schema             => $sample_schema,
    memory_mgmt_type          => $memory_mgmt_type,
    storage_type              => $storage_type,
    puppet_download_mnt_point => $puppet_download_mnt_point,
    sys_password              => $sys_password,
    db_conf_type              => $db_conf_type,
    cluster_nodes             => $cluster_nodes,
  }

  -> ora_setting { $dbname:
    default     => true,
    oracle_home => $oracle_home,
  }
  #
  # Database is done. Now start it
  #
  -> db_control {'database started':
    ensure                  => 'start',
    provider                => $ora_profile::database::db_control_provider,
    instance_name           => $dbname,
    oracle_product_home_dir => $oracle_home,
  }

}
