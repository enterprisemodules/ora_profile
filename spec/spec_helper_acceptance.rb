require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppetlabs_spec_helper/puppet_spec_helper'
require 'beaker-rspec/spec_helper'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
require 'easy_type_helpers/acceptance'
Dir["./spec/support/acceptance/**/*.rb"].sort.each { |f| require f }

unless ENV['RS_PROVISION'] == 'no'
  run_puppet_install_helper
  install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ %r{pe}i

  hosts.each do |host|
    on host, 'rm -rf /etc/puppetlabs/code/environments/production/modules'
    on host, 'mkdir /etc/puppetlabs/code/environments/production/modules'
    on host, "mkdir -p #{host['distmoduledir']}"
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation
  c.order     = :defined
  c.include Helpers

  # Copy module root and easy_type to docker container
  c.before :suite do
    # em_license_file = ENV['EM_LICENSE_FILE']
    # fail 'You neeed to set $EM_LICENSE_FILE' if em_license_file.nil?
    em_license_file = '/software/Universal.entitlements'
    on(master, "cp #{em_license_file} /etc/puppetlabs/puppet/")
    copy_module_to(master, :source => proj_root,
                           :ignore_list => ['software'],
                           :target_module_path => '/etc/puppetlabs/code/environments/production/modules',
                           :module_name => 'ora_profile')

    on(master, "mkdir -p /etc/puppetlabs/puppet/data")
    scp_to(master, "#{proj_root}/spec/hiera.yaml",'/etc/puppetlabs/puppet/hiera.yaml',  )
    scp_to(master, "#{proj_root}/spec/acceptance_hiera_data.yaml",'/etc/puppetlabs/puppet/data')
    #
    # Install required modules
    #
    on(master, "puppet module install puppet-archive --force")
    on(master, 'puppet module install saz-limits --force')
    on(master, 'puppet module install herculesteam-augeasproviders_sysctl --force')
    on(master, 'puppet module install enterprisemodules-easy_type --force')
    on(master, 'puppet module install enterprisemodules-ora_install --force')
    on(master, 'puppet module install enterprisemodules-ora_config --force')
    on(master, 'puppet module install puppetlabs-stdlib --force')
    on(master, 'puppet module install ipcrm-echo --force')
    on(master, 'puppet module install puppet-archive --force')
    on(master, 'puppet module install herculesteam-augeasproviders_core --force')
    on(master, 'puppet module install herculesteam-augeasproviders_sysctl --force')
    on(master, 'puppet module install saz-limits --force')
    on(master, 'puppet module install puppetlabs-firewall --force')
    on(master, 'puppet module install crayfishx-firewalld --force')
  end
end
