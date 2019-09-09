require_relative '../spec_helper_acceptance'


describe 'ora_profile::database' do

  context 'when applying Oracle 18.0.0.0' do
    it_should_behave_like "a database installer",
      version: '18.0.0.0',
      file: 'LINUX.X64_180000_db_home',
      klass: 'ora_profile::database'
  end

end
