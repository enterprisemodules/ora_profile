require 'spec_helper'

describe 'ora_profile::database::db_definition' do

  let(:pre_condition) { 
    """
      class { 'ora_profile::database::db_definition':
        system_password => Sensitive('Welcome01!'),
        sys_password    => Sensitive('Welcome01!'),
      }
    """
  }

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      next if os =~ /windows/
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
