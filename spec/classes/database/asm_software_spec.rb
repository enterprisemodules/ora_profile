require 'spec_helper'

describe 'ora_profile::database::asm_software' do
  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      if os =~ /centos-8/
        let(:facts) { os_facts.merge({networking: {hostname: 'foo'}}) }
        let(:test_params) {{}}
        let(:params) {{
          asm_sys_password:       RSpec::Puppet::RawString.new("Sensitive('Welcome01!')"),
          dirs:                   ['/dir1', '/dir2'],
          cluster_name:           'cluster_name',
          scan_name:              'scan_name',
          scan_port:              1234,
          cluster_node_types:     'types',
          network_interface_list: 'eth0',
          storage_option:         'CLIENT_ASM_STORAGE',
        }.merge(test_params)}
        context "version 18.0.0.0" do
          let(:test_params) {{
            version:                '18.0.0.0',
          }}
          it { is_expected.to compile }
          it { is_expected.to contain_file('/install/add_node_foo.rsp')
            .with('path'    => '/install/add_node_foo.rsp')
            .with('ensure'  => 'file')
            .with('content' => /INVENTORY_LOCATION=\/u01\/app\/oraInventory/ )
            .with('content' => /ORACLE_BASE=\/u01\/app\/grid\/admin/ )
            .with('content' => /oracle.install.crs.config.clusterName=cluster_name/ )
            .with('content' => /oracle.install.crs.config.networkInterfaceList=eth0/ )
            .with('content' => /oracle.install.crs.config.clusterNodes=foo:foo-vip:HUB/ )
          }
        end
        context "version 19.0.0.0" do
          let(:test_params) {{
            version:                '19.0.0.0',
          }}
          it { is_expected.to compile }
          it { is_expected.to contain_file('/install/add_node_foo.rsp')
            .with('path'    => '/install/add_node_foo.rsp')
            .with('ensure'  => 'file')
            .with('content' => /INVENTORY_LOCATION=\/u01\/app\/oraInventory/ )
            .with('content' => /ORACLE_BASE=\/u01\/app\/grid\/admin/ )
            .with('content' => /oracle.install.crs.config.clusterName=cluster_name/ )
            .with('content' => /oracle.install.crs.config.networkInterfaceList=eth0/ )
            .with('content' => /oracle.install.crs.config.clusterNodes=foo:foo-vip/ )
          }
        end
      end
    end
  end
end
