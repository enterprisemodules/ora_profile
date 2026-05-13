require 'spec_helper'

describe 'ora_profile::database::asm_diskgroup' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      next if os =~ /windows/
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
