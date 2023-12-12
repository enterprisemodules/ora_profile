require 'spec_helper'

describe 'ora_profile::database::utility::stop_for_patching' do
  let(:pre_condition) { <<-PUPPET
      schedule { 'db_patchschedule':
        range  => '00:00-23:59',
      }
    PUPPET
  }

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      next if os =~ /windows/

      let(:title) {['/home1','/home2']}
      let(:test_facts) {{}}
      let(:facts) { os_facts.merge(test_facts) }
      let(:params) {{
        'os_user'  => 'oracle',
        'schedule' => 'db_patchschedule'
      }}

      it { is_expected.to compile.with_all_deps }

      context "Oracle not running on both homes and OCM not running" do
        include_context "Oracle not running on both homes and OCM not running"

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "NOT stopping Oracle on home", '/home1', 'DB1'
        it_should_behave_like "NOT stopping Oracle on home", '/home2', 'DB2'
        it_should_behave_like "NOT stopping OCM"
      end

      context "No Listeners running" do
      include_context "No Listeners running"

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "NOT stopping listener", '/home1','LISTENER1'
        it_should_behave_like "NOT stopping listener", '/home1','LISTENER2'
        it_should_behave_like "NOT stopping listener", '/home2','LISTENER3'
        it_should_behave_like "NOT stopping listener", '/home2','LISTENER4'
      end

      context "Oracle running on home1 and OCM running from home3" do
        include_context "Oracle running on home1 and OCM running from home3"

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "stopping Oracle on home", '/home1', 'DB1'
        it_should_behave_like "NOT stopping Oracle on home", '/home2', 'DB2'
        it_should_behave_like "NOT stopping OCM"
      end

      context "Oracle running on home1 and home2 OCM running from home3" do
        include_context "Oracle running on home1 and home2 OCM running from home3" 

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "stopping Oracle on home", '/home1', 'DB1'
        it_should_behave_like "stopping Oracle on home", '/home2', 'DB2'
        it_should_behave_like "NOT stopping OCM"
      end

      context "one LISTENER running in one home" do
        include_context "one LISTENER running in one home"

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "stopping listener", '/home1', 'LISTENER1'
        it_should_behave_like "NOT stopping listener", '/home1', 'LISTENER2'
        it_should_behave_like "NOT stopping listener", '/home2', 'LISTENER3'
        it_should_behave_like "NOT stopping listener", '/home2', 'LISTENER4'
      end

      context "Multiple listeners running in multiple homes" do
        include_context "Multiple listeners running in multiple homes"

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "stopping listener", '/home1', 'LISTENER1'
        it_should_behave_like "stopping listener", '/home1', 'LISTENER2'
        it_should_behave_like "stopping listener", '/home2', 'LISTENER3'
        it_should_behave_like "stopping listener", '/home2', 'LISTENER4'
      end

      context "OCM running" do
        include_context "OCM running"

        it { is_expected.to compile.with_all_deps }
        it_should_behave_like "stopping OCM"
      end
    end
  end
end
