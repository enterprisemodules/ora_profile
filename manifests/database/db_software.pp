# ora_profile::database::db_software
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include ora_profile::database::db_software
class ora_profile::database::db_software(
  Enum['12.2.0.1','12.1.0.1','12.1.0.2','11.2.0.3','11.2.0.4', '11.2.0.1']
            $version,
  Enum['SE2', 'SE', 'EE', 'SEONE']
            $database_type,
  Array[Stdlib::Absolutepath]
            $dirs,
  String[1] $dba_group,
  String[1] $install_group,
  String[1] $os_user,
  Stdlib::Absolutepath
            $oracle_base,
  Stdlib::Absolutepath
            $oracle_home,
  String[1] $source,
  String[1] $file_name,
) inherits ora_profile::database {
  echo {'DB software':}

  unless defined(Package['unzip']) {
    package { 'unzip':
      ensure => 'present',
    }
  }

  file{$dirs:
    ensure  => directory,
    owner   => $os_user,
    group   => $dba_group,
    seltype => 'default_t',
    mode    => '0744',
  }

  -> file{'/tmp': ensure => 'directory'}

  -> ora_install::installdb{$file_name:
    version                   => $version,
    file                      => $file_name,
    database_type             => $database_type,
    oracle_base               => $oracle_base,
    oracle_home               => $oracle_home,
    puppet_download_mnt_point => $source,
    require                   => Package['unzip'],
  }

  -> file {"${oracle_base}/admin":
    ensure => 'directory',
    owner  => $os_user,
    group  => $install_group,
    mode   => '0775',
  }

}
