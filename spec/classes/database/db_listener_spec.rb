require 'spec_helper'

describe 'ora_profile::database::db_listener' do
  include_context 'specify passwords'

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
