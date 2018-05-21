#++--++
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
  String[1]           $template_type,
  String[1]           $data_file_destination,
  String[1]           $recovery_area_destination,
  String[1]           $sample_schema,
  String[1]           $memory_mgmt_type,
  String[1]           $storage_type,
  String[1]           $puppet_download_mnt_point,
  String[1]           $system_password,
  String[1]           $sys_password,
  Optional[String[1]] $cluster_nodes = undef,
) inherits ora_profile::database {

  echo {"DB definition from template for database ${dbname} in ${oracle_home}":
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
    provider                => 'sqlplus',
    oracle_product_home_dir => $oracle_home,
  }

}
