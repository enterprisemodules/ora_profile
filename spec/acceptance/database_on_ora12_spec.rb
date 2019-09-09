require_relative '../spec_helper_acceptance'


describe 'ora_profile::database' do


  context 'when applying Oracle 12.2.0.1' do
    it_should_behave_like "a database installer",
      version: '12.2.0.1',
      file: 'linuxx64_12201_database',
      klass: 'ora_profile::database'
  end

  context 'when applying Oracle 12.1.0.2', :older_version do
    it_should_behave_like "a database installer",
      version: '12.1.0.2',
      file: 'linuxamd64_12102_database',
      klass: 'ora_profile::database'
  end

end
