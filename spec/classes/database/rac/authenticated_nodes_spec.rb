require 'spec_helper'

describe 'ora_profile::database::rac::authenticated_nodes' do
  let(:pre_condition) do
    <<~PUPPET
      # database.pp only runs the asm_groups_and_users step when ASM is in
      # play, so User[grid] is not declared in this test scenario. The
      # oracle user does come in via the regular groups_and_users step.
      user { 'grid': ensure => present }
      class { 'ora_profile::database::rac::authenticated_nodes':
        grid_private_key   => 'dummy-grid-private-key',
        oracle_private_key => 'dummy-oracle-private-key',
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
