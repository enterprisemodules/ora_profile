require 'spec_helper'

RSpec.shared_examples "not stopping, starting & updating DB & OCM" do
  it { is_expected.to_not contain_ora_profile__database__utility__stop_for_patching('/u01/app/oracle/product/19.0.0.0/db_home1')}
  # Don't do any patches
  it { is_expected.to_not contain_ora_profile__database__utility__start_after_patching('/u01/app/oracle/product/19.0.0.0/db_home1')}
  # Don't do the update
  it { is_expected.to_not contain_ora_profile__database__utility__update_after_patching('/u01/app/oracle/product/19.0.0.0/db_home1')}
end

RSpec.shared_examples "Stopping, starting and updating DB & OCM" do
  it { is_expected.to contain_ora_profile__database__utility__stop_for_patching('/u01/app/oracle/product/19.0.0.0/db_home1')
    .with('os_user'   => 'oracle')
    .with('schedule'  => 'db_patchschedule')
    .that_comes_before('Ora_opatch[/u01/app/oracle/product/19.0.0.0/db_home1:35037840-GIRU-19.19.0.0.230418]')
  }

  it { is_expected.to contain_ora_profile__database__utility__start_after_patching('/u01/app/oracle/product/19.0.0.0/db_home1')
    .with('os_user'   => 'oracle')
    .with('schedule'  => 'db_patchschedule')
    .that_requires('Ora_opatch[/u01/app/oracle/product/19.0.0.0/db_home1:35037840-GIRU-19.19.0.0.230418]')
    .that_comes_before('Ora_profile::Database::Utility::Update_after_patching[/u01/app/oracle/product/19.0.0.0/db_home1]')
  }

  it { is_expected.to contain_ora_profile__database__utility__update_after_patching('/u01/app/oracle/product/19.0.0.0/db_home1')
    .with('os_user'   => 'oracle')
    .with('schedule'  => 'db_patchschedule')
  }

end

RSpec.shared_examples "Applying patches" do | schedule|
  it { is_expected.to contain_ora_opatch('/u01/app/oracle/product/19.0.0.0/db_home1:35037840-GIRU-19.19.0.0.230418')
    .with('oracle_product_home_dir' => '/u01/app/oracle/product/19.0.0.0/db_home1')
    .with('patch_id'                => '35037840-GIRU-19.19.0.0.230418')
    .with('ensure'                  => 'present')
    .with('tmp_dir'                 => '/install/patches')
    .with('schedule'                => schedule)
    .with('source'                  => 'puppet:///modules/software/p35037840_190000_Linux-x86-64.zip')
    .with('sub_patches'             => '["35042068", "35050331"]')
  }
end

RSpec.shared_examples "Not Applying patches" do
  it { is_expected.not_to contain_ora_opatch('/u01/app/oracle/product/19.0.0.0/db_home1:35037840-GIRU-19.19.0.0.230418')}
end


describe 'ora_profile::database::db_patches' do

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      next if os =~ /windows/

      let(:test_facts) {{}}
      let(:test_params) {{}}
      let(:facts) { os_facts.merge(test_facts) }
      let(:params) {{
      }.merge(test_params)}


      context "Oracle and OCM not running" do
        let(:test_facts) {{ora_version: nil}}

        it { is_expected.to compile.with_all_deps }
        # Do notify users
        it { is_expected.to contain_echo('Ensure DB patch level APR2023RU on /u01/app/oracle/product/19.0.0.0/db_home1')}

        it_should_behave_like "not stopping, starting & updating DB & OCM"
        it_should_behave_like "Applying patches", nil
      end

      context "All patches already installed" do

        let(:test_facts) {{
          'ora_install_homes' => {
            "installed_patches" => {
              "/u01/app/oracle/product/19.0.0.0/db_home1" => [
                "35042068",
                "35050331"
              ]
            },
            "opatch_version" => {
              "/u01/app/oracle/product/19.0.0.0/db_home1" => "12.2.0.1.37"
            },
          }
        }}


        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_echo('All DB patches already installed. Skipping patches.')}
        it_should_behave_like "not stopping, starting & updating DB & OCM"
        it_should_behave_like "Not Applying patches"
      end

      context "Oracle is running" do
        let(:test_facts) {{ora_version: '19.0.0.0'}}

        context "Patch window is undef" do
          let(:pre_condition) { <<-PUPPET
            class { 'ora_profile::database::common':
              patch_window => undef,
            }
          PUPPET
          }

          it { is_expected.to compile.with_all_deps }
          # Do notify users
          it { is_expected.to contain_echo('DB patching disabled because no patch window is defined')}
          it_should_behave_like "not stopping, starting & updating DB & OCM"
          it_should_behave_like  "Not Applying patches"

        end

        context "Running with patch window" do
          let(:test_facts) {{ora_version: '19.0.0.0'}}
          let(:pre_condition) { <<-PUPPET
            class { 'ora_profile::database::common':
              patch_window => "00:00 - 23:59",
            }
          PUPPET
          }

          it { is_expected.to compile.with_all_deps }
          # Notification to users
          it { is_expected.to contain_echo('Ensure DB patch level APR2023RU on /u01/app/oracle/product/19.0.0.0/db_home1')}
          it { is_expected.to contain_echo('Ensure DB patch(es) in patch window: 00:00 - 23:59')}
          it { is_expected.to contain_schedule('db_patchschedule')
            .with('range' => '00:00 - 23:59')
          }
          it { is_expected.to contain_echo('Apply DB patch(es) /u01/app/oracle/product/19.0.0.0/db_home1:35042068,/u01/app/oracle/product/19.0.0.0/db_home1:35050331')
            .with('schedule' => 'db_patchschedule')
          }

          it_should_behave_like "Stopping, starting and updating DB & OCM"
          it_should_behave_like "Applying patches", 'db_patchschedule'
        end
      end
    end
  end
end
