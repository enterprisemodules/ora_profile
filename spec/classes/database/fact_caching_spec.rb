require 'spec_helper'

describe 'ora_profile::database::fact_caching' do

  on_supported_os(:facterversion => '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_class('Ora_config::Fact_caching')
        .with('enabled' => 'false')}

        it { is_expected.to contain_class('Ora_install::Fact_caching')
            .with('enabled' => 'false')}
    end
  end
end
