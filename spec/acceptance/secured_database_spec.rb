require_relative '../spec_helper_acceptance'

describe 'ora_profile::database' do
  manifest = <<-MANIFEST
    contain ora_profile::secured_database
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
    it { should contain('ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/db_home1') }
    it { should contain('SQLPLUS_HOME=/u01/app/oracle/product/12.2.0.1/db_home1') }
  end

  it 'is idempotent on second run' do
    apply_manifest(manifest, :expect_changes => false)
  end
end
