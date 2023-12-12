RSpec.configure do |c|
  c.mock_with :rspec
end

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'puppet-catalog_rspec'
# rubocop: disable Style/MixinUsage
include RspecPuppetFacts
# rubocop: enable Style/MixinUsage

default_facts = {
  :puppetversion => Puppet.version,
  :facterversion => Facter.version
}

default_facts_path = File.expand_path(File.join(File.dirname(__FILE__), 'default_facts.yml'))
default_module_facts_path = File.expand_path(File.join(File.dirname(__FILE__), 'default_module_facts.yml'))

default_facts.merge!(YAML.safe_load(File.read(default_facts_path))) if File.exist?(default_facts_path) && File.readable?(default_facts_path)

default_facts.merge!(YAML.safe_load(File.read(default_module_facts_path))) if File.exist?(default_module_facts_path) && File.readable?(default_module_facts_path)
require_relative 'support/unit/shared_examples'

RSpec.configure do |c|
  c.default_facts = default_facts
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))
  # c.before(:each) do
  #   Puppet::Util::Log.level = :debug
  #   Puppet::Util::Log.newdestination(:console)
  # end
end
