#++--++
#
# ora_profile::database::db_definition_template
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
# @param [Ora_Install::Version] version
#    The version of Oracle you want to install.
#    The default is : `12.2.0.1`
#    To customize this consistently use the hiera key `ora_profile::database::version`.
#
# @param [Stdlib::Absolutepath] oracle_home
#    The home directory to use for the Oracle installation.
#    The default is : `/u01/app/oracle/product/#{version}/db_home1`
#    To customize this consistently use the hiera key `ora_profile::database::oracle_home`.
#
# @param [Stdlib::Absolutepath] oracle_base
#    The base directory to use for the Oracle installation.
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
# @param [Easy_type::Password] system_password
#    The `system` password to use for the database.
#    The default value is: `Welcome01`
#
# @param [Easy_Type::Password] sys_password
#    The `sys` password to use for the database.
#    The default value is: `Change_on_1nstall`
#
# @param [Enum['SINGLE', 'RAC', 'RACONE']] db_conf_type
#    The type of database that needs to be installed.
#    Valid values are:
#    - `SINGLE`
#    - `RAC`
#    - `RACONE`
#    The default value is `SINGLE`
#
# @param [String[1]] log_size
#    The log ize to use.
#    The default is : `100M`
#
# @param [String[1]] dbdomain
#    The domain of the database.
#    The default is `$facts['networking']['domain']`
#
# @param [Variant[Boolean, Enum['on_failure']]] logoutput
#    log the outputs of Puppet exec or not.
#    When you specify `true` Puppet will log all output of `exec` types.
#    Valid values are:
#    - `true`
#    - `false`
#    - `on_failure`
#
#--++--
class ora_profile::database::db_definition_template(
  Ora_Install::Version
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
  Easy_type::Password
                      $system_password,
  Easy_Type::Password
                      $sys_password,
  Enum['SINGLE','RAC','RACONE']
                      $db_conf_type,
  String[1]           $log_size,
  String[1]           $dbdomain,
  Variant[Boolean,Enum['on_failure']]
                      $logoutput = lookup({name => 'logoutput', default_value => 'on_failure'}),
) inherits ora_profile::database {
# lint:ignore:variable_scope

  echo {"Ensure DB definition from template for database ${dbname} in ${oracle_home}":
    withpath => false,
  }

  #
  # All standard values fetched in data function
  #
  $split_version = split($version, '[.]')
  $db_version = "${split_version[0]}.${split_version[1]}"
  if ( $cluster_nodes ) {
    $db_cluster_nodes = $master_node
  } else {
    $db_cluster_nodes = undef
  }

  if ( $master_node == $facts['hostname'] ) {
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
      download_dir              => $download_dir,
      sys_password              => $sys_password,
      system_password           => $system_password,
      db_conf_type              => $db_conf_type,
      cluster_nodes             => $db_cluster_nodes,
      db_domain                 => $dbdomain,
      before                    => Ora_setting[$db_instance_name],
    }
  } else {
    exec{'add_instance':
      user        => $os_user,
      environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO', "ORACLE_HOME=${oracle_home}"],
      command     => "${oracle_home}/bin/srvctl add instance -d ${dbname} -i ${db_instance_name} -n ${::hostname}",
      unless      => "${oracle_home}/bin/srvctl status instance -d ${dbname} -i ${db_instance_name}",
      logoutput   => $logoutput,
    }

    -> exec{'start_instance':
      user        => $os_user,
      environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO',"ORACLE_HOME=${oracle_home}"],
      command     => "${oracle_home}/bin/srvctl start instance -d ${dbname} -i ${db_instance_name}",
      onlyif      => "${oracle_home}/bin/srvctl status instance -d ${dbname} -i ${db_instance_name} | grep not",
      logoutput   => $logoutput,
    }
  }

  ora_setting { $db_instance_name:
    default     => true,
    oracle_home => $oracle_home,
  }

  -> ora_tab_entry{ $db_instance_name:
    ensure      => 'present',
    oracle_home => $oracle_home,
    startup     => 'N',
  }

  #
  # Database is done. Now start it
  #
  -> db_control {'database started':
    ensure                  => 'start',
    provider                => $db_control_provider,
    instance_name           => $dbname,
    oracle_product_home_dir => $oracle_home,
    os_user                 => $os_user,
  }

  if ( $is_rac ) {
    $cluster_nodes.each |$index, $node| {
      $inst_number = $index + 1
      ora_profile::database::rac::instance {"${dbname}${inst_number}":
        on                => $db_instance_name,
        number            => $inst_number,
        thread            => $inst_number,
        datafile          => $data_file_destination,
        undo_initial_size => '100M',
        undo_next         => '100M',
        undo_autoextend   => 'on',
        undo_max_size     => 'unlimited',
        log_size          => $log_size,
      }

      ## Might be needed for older versions
      # exec {"create pfile for ${dbname}${instance_number}":
      #   command     => "echo -e \"set heading off\nselect 'spfile='''||value||'''' from v\\\$parameter where name = 'spfile';\" | ${oracle_home}/bin/sqlplus -S / as sysdba | grep -v ^\$ > ${oracle_home}/dbs/init${dbname}${instance_number}.ora",
      #   cwd         => '/tmp',
      #  environment => ["ORACLE_SID=${db_instance_name}", 'ORAENV_ASK=NO',"ORACLE_HOME=${oracle_home}"],
      #   path        => '/bin',
      #   user        => $ora_profile::database::os_user,
      #   unless      => "stat ${oracle_home}/dbs/init${dbname}${instance_number}.ora",
      # }
    }
  }
}
# lint:endignore
