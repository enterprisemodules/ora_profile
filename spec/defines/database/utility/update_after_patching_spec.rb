require 'spec_helper'

describe 'ora_profile::database::utility::update_after_patching' do

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      next if os =~ /windows/

      let(:title) {['/home1','/home2']}
      let(:test_facts) {{}}
      let(:facts) { os_facts.merge(test_facts) }
      let(:params) {{
        'os_user'  => 'oracle',
        'schedule' => 'db_schedule'
      }}

      it { is_expected.to compile.with_all_deps }

      context "Oracle not running on both homes" do
        let(:test_facts) {{
          "ora_install_homes" => {
            "running_processes" => {
              "/home1" => {
                "conn_mgrs": [],
                "listeners" => [],
                "sids" => {}
              },
              "/home2" => {
                "conn_mgrs": [],
                "listeners" => [],
                "sids" => {}
                }
              }
            }
          }}

        it { is_expected.to compile.with_all_deps }

        it_should_behave_like "NOT updating Oracle on home", '/home1', 'DB1'
        it_should_behave_like "NOT updating Oracle on home", '/home2', 'DB2'
      end


      context "Oracle running on home1" do
        let(:test_facts) {{
          "ora_install_homes" => {
            "running_processes" => {
              "/home1" => {
                "conn_mgrs": [],
                "listeners" => [],
                "sids" => {
                  "DB1" => {
                    "database_role" => "PRIMARY",
                    "open_mode" => "READ_WRITE"
                  }
                }
              },
              "/home2" => {
                "conn_mgrs": [],
                "listeners" => [],
                "sids" => {},
              }
            }
          }
        }}

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "updating Oracle on home", '/home1', 'DB1'
        it_should_behave_like "NOT updating Oracle on home", '/home2', 'DB2'
      end

      context "Oracle running on home1 and home2" do
        let(:test_facts) {{
          "ora_install_homes" => {
            "running_processes" => {
              "/home1" => {
                "conn_mgrs": [],
                "listeners" => [
                  "LISTENER1",
                  "LISTENER2"
                ],
                "sids" => {
                  "DB1" => {
                    "database_role" => "PRIMARY",
                    "open_mode" => "READ_WRITE"
                  }
                }
              },
              "/home2" => {
                "conn_mgrs": [],
                "listeners" => [
                  "LISTENER3",
                  "LISTENER4"
                ],
                "sids" => {
                  "DB2" => {
                    "database_role" => "PRIMARY",
                    "open_mode" => "READ_WRITE"
                  }
                }
              }
            }
          }
        }}

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "updating Oracle on home", '/home1', 'DB1'
        it_should_behave_like "updating Oracle on home", '/home2', 'DB2'
      end

    end
  end
end
