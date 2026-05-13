require 'spec_helper'

describe 'ora_profile::database::db_definition_template' do
  let(:pre_condition) do
    <<~PUPPET
      class { 'ora_profile::database::db_definition_template':
        sys_password    => Sensitive('Welcome01!'),
        system_password => Sensitive('Welcome01!'),
      }
    PUPPET
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      next if os =~ /windows/
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
