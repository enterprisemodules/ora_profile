require_relative '../spec_helper_acceptance'


describe 'ora_profile::database' do

  context 'when applying Oracle 21.0.0.0' do
    it_should_behave_like "a database installer",
      version: '21.0.0.0',
      file: 'LINUX.X64_213000_db_home',
      klass: 'ora_profile::database'
  end

end
