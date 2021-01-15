require 'spec_helper'

describe 'ora_profile::database::rac::instance' do
  let(:pre_condition) { 
    """
      contain ora_profile::database
    """
  }

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:title) {'title'}
      let(:facts) { os_facts }
      let(:params) {{
        :on => 's',
        :number => 1,
        :thread => 12,
        :datafile => 'data',
        :undo_initial_size => 1024,
        :undo_next =>  1024,
        :undo_autoextend =>  'on',
        :undo_max_size =>  1024,
        :log_size =>  1024,
      }}
      next if os =~ /windows/
      if os =~ /centos-8/
        it { is_expected.to compile }
        it { is_expected.to contain_file('/install/add_logfiles_12.sql')
          .with('content' => /alter database add logfile thread 12 size 1024;/)
        }
      end
    end
  end
end
