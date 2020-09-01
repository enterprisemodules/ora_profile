require 'spec_helper'

describe 'ora_profile::database::asm_storage::asmlib' do

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      if os =~ /centos-8/

        let(:pre_condition) {
          """
            package { 'oracleasm-support':
              ensure  => installed,
            }
            partition { '/dev/device:1':
              ensure  => 'present',
            }

          """
        }

        let(:facts) { os_facts }
        let(:params) {{
          grid_user: 'usr',
          grid_admingroup: 'group',
          disk_devices: {device: {label:'dev1'}},
          scan_exclude: 'exclude',
        }}
        it { is_expected.to compile }

        it { is_expected.to contain_file('/etc/sysconfig/oracleasm-_dev_oracleasm')
          .with('content' => /ORACLEASM_UID=usr/)
          .with('content' => /ORACLEASM_GID=group/)
          .with('content' => /ORACLEASM_SCANEXCLUDE=\"exclude\"/)
        }
      end
    end
  end
end
