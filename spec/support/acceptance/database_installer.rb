shared_examples "a database installer" do | settings|
  klass   = settings.fetch(:klass)
  version = settings.fetch(:version)
  file    = settings.fetch(:file)

  before do
    used_hiera_values = {
      'ora_profile::database::cis_controls::product_version'                     => 'db19c',
      'ora_profile::database::cis_controls::doc_version'                         => 'V1.0.0',
      'easy_type::generate_password_mode'                                        => 'development',
      'ora_profile::database::version'                                           => version,
      'ora_profile::database::source'                                            => '/software',
      'ora_profile::database::db_software::file_name'                            => file,
      'ora_profile::database::sysctl'                                            => 'skip',
      'ora_profile::database::manage_thp'                                        => 'skip',
      'ora_profile::database::firewall'                                          => 'skip',
      'ora_profile::database::db_patches'                                        => 'skip',
      # 'ora_profile::database::cis_controls::product_version'                     => 'db12c',  # This works on all versions
      # 'ora_profile::database::cis_controls::doc_version'                         => 'V3.0.0',
      'ora_profile::database::cis_controls::skip_list'                           => ['create_user_action_audit_is_enabled'],
      'ora_profile::database::db_definition_template::data_file_destination'     => '/u02/oradata',
      'ora_profile::database::db_definition_template::recovery_area_destination' => '/u03/fast_recovery_area',
      'ora_profile::database::db_definition_template::storage_type'              => 'FS',
      'ora_profile::database::db_definition'                                     => 'ora_profile::database::db_definition_template',
      'ora_profile::database::db_tablespaces::list'                              => {'TEST_TS' => {
          'ensure'            => 'present',
          'autoextend'        => 'on',
          'contents'          => 'permanent',
          'datafile'          => ['/u02/oradata/DB01/test_ts.dbf'],
          'extent_management' => 'local',
          'logging'           => 'yes',
          'max_size'          => '100M',
          'next'              => '5M',
          'size'              => '10M',
        }
      },
      'ora_profile::database::db_profiles::list'                                 => { 'TEST_PROFILE' => {
          'ensure'                    => 'present',
          'composite_limit'           => 'UNLIMITED',
          'connect_time'              => 'UNLIMITED',
          'container'                 => 'local',
          'cpu_per_call'              => 'UNLIMITED',
          'cpu_per_session'           => 'UNLIMITED',
          'failed_login_attempts'     => 5,
          'idle_time'                 => 'UNLIMITED',
          'logical_reads_per_call'    => 'UNLIMITED',
          'logical_reads_per_session' => 'UNLIMITED',
          'password_grace_time'       => 5,
          'password_life_time'        => 90,
          'password_lock_time'        => 1,
          'password_reuse_max'        => 20,
          'password_reuse_time'       => 365,
          'password_verify_function'  => 'ORA12C_STRONG_VERIFY_FUNCTION',
          # 'private_sga'               => 'UNLIMITED', # Not idempotent for now
          'sessions_per_user'         => 10,
        }
      },
      'ora_profile::database::db_users::list'                                    => { 'USER_TEST' => {
          'ensure'               => 'present',
          'default_tablespace'   => 'SYSTEM',
          'expired'              => true,
          'locked'               => true,
          'password'             => 'S3cre#St8ff&',
          'profile'              => 'DEFAULT',
          'temporary_tablespace' => 'TEMP',
        }
      }
    }
    version_21_hiera_values = {
      'ora_profile::database::cis_controls::skip_list'                           => [
        'remote_os_authent_is_set_to_false',
        'sec_case_sensitive_logon_is_set_to_true',
      ],
      'ora_profile::database::db_definition_template::container_database'        => 'enabled',
      'ora_profile::database::db_definition_template::memory_mgmt_type'          => 'CUSTOM_SGA',
      'ora_profile::database::db_definition_template::init_params'               => 'sga_max_size=1024m,java_pool_size=64m,shared_pool_size=512m',
      'ora_profile::database::db_profiles::list'                                 => { 'C##TEST_PROFILE' => {
          'ensure'                    => 'present',
          'composite_limit'           => 'UNLIMITED',
          'connect_time'              => 'UNLIMITED',
          'container'                 => 'common',
          'cpu_per_call'              => 'UNLIMITED',
          'cpu_per_session'           => 'UNLIMITED',
          'failed_login_attempts'     => 5,
          'idle_time'                 => 'UNLIMITED',
          'logical_reads_per_call'    => 'UNLIMITED',
          'logical_reads_per_session' => 'UNLIMITED',
          'password_grace_time'       => 5,
          'password_life_time'        => 90,
          'password_lock_time'        => 1,
          'password_reuse_max'        => 20,
          'password_reuse_time'       => 365,
          'password_verify_function'  => 'ORA12C_STRONG_VERIFY_FUNCTION',
          # 'private_sga'               => 'UNLIMITED', # Not idempotent for now
          'sessions_per_user'         => 10,
        }
      },
      'ora_profile::database::db_users::list'                                   => { 'C##USER_TEST' => {
          'ensure'               => 'present',
          'container'            => 'common',
          'default_tablespace'   => 'SYSTEM',
          'expired'              => true,
          'locked'               => true,
          'password'             => 'S3cre#St8ff&',
          'profile'              => 'DEFAULT',
          'temporary_tablespace' => 'TEMP',
        }
      }
    }
    used_hiera_values.delete('ora_profile::database::db_profiles::list') if version == '21.0.0.0'
    used_hiera_values.delete('ora_profile::database::db_users::list') if version == '21.0.0.0'
    used_hiera_values.merge!(version_21_hiera_values) if version == '21.0.0.0'
    hiera_values_on_sut(used_hiera_values)
  end

  # after(:all) do
  #   # Cleanup all
  #   run_shell('killall -u oracle -w || true')
  #   run_shell('rm -rf /u01 /u02 /u03 /home/oracle || true')
  #   run_shell('userdel oracle; groupdel dba; groupdel oinstall|| true')
  # end

  manifest = <<-MANIFEST
    contain #{klass}
  MANIFEST

  it 'installs the oracle software' do
    apply_manifest(manifest, :expect_changes => true)
  end

  #
  # The database directory should be made
  #
  describe file('/u01/app/oracle') do
    it { should be_directory }
    it { should be_owned_by('oracle') }
    it { should be_grouped_into('oinstall') }
  end

  #
  # The oracle user and its profile should be set
  #
  describe file('/home/oracle/.bash_profile') do
    it { should be_file }
    it { should be_owned_by('oracle') }
    it { should be_mode(775) }
    it { should be_grouped_into('dba') }
    it { should contain('ORACLE_BASE=/u01/app/oracle') }
    it { should contain("ORACLE_HOME=/u01/app/oracle/product/#{version}/db_home1") }
    it { should contain("SQLPLUS_HOME=/u01/app/oracle/product/#{version}/db_home1") }
  end

  it 'is idempotent on next run' do
    #
    # ora_secured::ensure_cis needs some more run's before it is idempotent.
    #
    if klass == 'ora_profile::secured_database'
      apply_manifest(manifest, :expect_changes => true)
    end
    apply_manifest(manifest, :expect_changes => false)
  end
end
