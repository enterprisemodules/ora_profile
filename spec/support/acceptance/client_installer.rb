shared_examples "a client installer" do | settings|
    version = settings.fetch(:version)
    from    = settings.fetch(:from)
    file    = settings.fetch(:file)
  
    before do
        hiera_values_on_sut(
          'ora_profile::client::software::version'                   => version,
          'ora_profile::client::software::file'                      => file,
          'ora_profile::client::software::puppet_download_mnt_point' => from,
          'easy_type::generate_password_mode'                        => 'development',
        )
      end

    # after(:all) do
    #   # Cleanup all
    #   run_shell('killall -u oracle -w || true')
    #   run_shell('rm -rf /oracle /home/oracle/* || true')
    # end
  
    manifest = <<-MANIFEST
      include ora_profile::client
    MANIFEST
  
    it 'installs the oracle client software' do
      apply_manifest(manifest, catch_failures: true)
    end
  
    #
    # The database directory should be made
    #
    describe file("/u01/app/oracle/#{version}/db_home1") do
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
      it { should be_mode(775)}
      it { should be_grouped_into('dba') }
      it { should contain('ORACLE_BASE=/u01/app/oracle') }
      it { should contain("ORACLE_HOME=/u01/app/oracle/#{version}/db_home1") }
      it { should contain("SQLPLUS_HOME=/u01/app/oracle/#{version}/db_home1") }
      end
  
    it 'is idempotent on second run' do
      apply_manifest(manifest, catch_changes: true)
    end
  end
  