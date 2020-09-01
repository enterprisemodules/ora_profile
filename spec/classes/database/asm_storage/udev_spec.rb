require 'spec_helper'

describe 'ora_profile::database::asm_storage::udev' do

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) {{
        grid_user: 'usr',
        grid_admingroup: 'group',
        disk_devices: {
          asm_data01:
            {
              size: 8192,
              uuid: '1ATA_VBOX_HARDDISK_VB00000000-01000000',
              label: 'DATA1',
            },
          asm_data02:
            {
              size: 8192,
              uuid: '1ATA_VBOX_HARDDISK_VB00000000-01000000',
              label: 'DATA2',
            }
        },
      }}
      if os =~ /centos-6/
        it { is_expected.to compile }
        it { is_expected.to contain_file('/etc/udev/rules.d/99-oracle-asmdevices.rules')
          .with('content' => /KERNEL=="sd\?", BUS=="scsi", PROGRAM=="\/sbin\/scsi_id --whitelisted --replace-whitespace --device=\/dev\/\$name", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", NAME="asm_data01", OWNER="usr", GROUP="group", MODE="0660"/)
          .with('content' => /KERNEL=="sd\?1", BUS=="scsi", PROGRAM=="\/sbin\/scsi_id --whitelisted --replace-whitespace --device=\/dev\/\$parent", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", NAME="asm_data01_1", OWNER="usr", GROUP="group", MODE="0660"/)
          .with('content' => /KERNEL=="sd\?", BUS=="scsi", PROGRAM=="\/sbin\/scsi_id --whitelisted --replace-whitespace --device=\/dev\/\$name", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", NAME="asm_data02", OWNER="usr", GROUP="group", MODE="0660"/)
          .with('content' => /KERNEL=="sd\?1", BUS=="scsi", PROGRAM=="\/sbin\/scsi_id --whitelisted --replace-whitespace --device=\/dev\/\$parent", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", NAME="asm_data02_1", OWNER="usr", GROUP="group", MODE="0660"/)
        }
      elsif os =~ /centos-7/
        it { is_expected.to compile }
        it { is_expected.to contain_file('/etc/udev/rules.d/99-oracle-asmdevices.rules')
          .with('content' => /KERNEL=="sd\*" SUBSYSTEM=="block", PROGRAM="\/usr\/lib\/udev\/scsi_id -g -u -d \/dev\/\$name", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", SYMLINK\+="asm_data01", OWNER="usr", GROUP="group", MODE="0660"/)
          .with('content' => /KERNEL=="sd\*1" SUBSYSTEM=="block", PROGRAM="\/usr\/lib\/udev\/scsi_id -g -u -d \/dev\/\$name", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", SYMLINK\+="asm_data01_1", OWNER="usr", GROUP="group", MODE="0660"/)
          .with('content' => /KERNEL=="sd\*" SUBSYSTEM=="block", PROGRAM="\/usr\/lib\/udev\/scsi_id -g -u -d \/dev\/\$name", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", SYMLINK\+="asm_data02", OWNER="usr", GROUP="group", MODE="0660"/)
          .with('content' => /KERNEL=="sd\*1" SUBSYSTEM=="block", PROGRAM="\/usr\/lib\/udev\/scsi_id -g -u -d \/dev\/\$name", RESULT=="1ATA_VBOX_HARDDISK_VB00000000-01000000", SYMLINK\+="asm_data02_1", OWNER="usr", GROUP="group", MODE="0660"/)
        }
      end
    end
  end
end
