require 'spec_helper'

describe 'ora_profile::database::asm_patches' do


  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      if os =~ /centos-8/
        let(:facts) { os_facts.merge({networking: {hostname: 'not_foo'}}) }
        let(:params) do
          {
            patch_list: { "path_home:1" => { source: "/patch", type: "one-off", sub_patches: {}} }
          }
        end
        it { is_expected.to compile }
        it { is_expected.to contain_file('/install/asm_patches/patch_grid_1.sh')
          .with('content' => /export ORACLE_HOME=path_home/)
          .with('content' => /export ORACLE_BASE=\/u01\/app\/grid\/admin/)
          .with('content' => /path_home\/gridSetup\.sh -silent -applyOneOffs  2\>\&1 > \/install\/asm_patches\/patch_grid_1.log/)
          .with('content' => /if grep -q "Successfully applied the patch." \/install\/asm_patches\/patch_grid_1\.log/)
          .with('content' => /cat \/install\/asm_patches\/patch_grid_1.log/)
        }
      end
    end
  end
end
