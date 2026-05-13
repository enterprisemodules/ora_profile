require 'spec_helper'

describe 'ora_profile::database::firewall::firewalld' do
  let(:params) do
    {
      cluster_nodes:  [],
      manage_service: true,
      ports:          { '1521' => 'tcp' },
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      next if os =~ /windows/
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
