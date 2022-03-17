
source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? "#{ENV['PUPPET_GEM_VERSION']}" : '7.1.0'

gem 'puppet', puppetversion, :require => false, :groups => [:test]
if Gem::Version.new(puppetversion) > Gem::Version.new('5.0.0')
  gem 'pdk',  '>1.9.0', '<1.14.0'
end

gem 'byebug'
group :unit_test do
  gem 'hiera-puppet-helper'
  gem 'rspec-puppet'
  gem 'rspec-puppet-utils'
  gem 'rspec-puppet-facts'
end

group :acceptance_test do
  if Gem::Version.new(puppetversion) >= Gem::Version.new('6.11.0')
    gem 'bolt'
    gem 'puppet_litmus'
  end
  gem 'serverspec'
  gem 'rspec-retry'
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.0.0')
    gem 'parallel_tests', '< 2.10.0'
  end
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.0.0')
    gem 'parallel_tests'
  end
end

group :release, :acceptance_test do
  if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.2.0')
    gem 'rake', '< 13.0.0'
  else
    gem 'rake'
  end
  gem 'puppet-blacksmith'
  gem 'em_tasks', :git => "https://github.com/enterprisemodules/em_tasks.git" if RUBY_VERSION > '2.1.2'
  gem 'puppet-strings'
end

group :quality do
  gem 'voxpupuli-puppet-lint-plugins'
  gem 'puppet-lint-uncuddled_else-check'
  gem 'puppet-lint-no_symbolic_file_modes-check'
  gem 'puppet-lint-no_erb_template-check'
  gem 'puppet-lint-package_ensure-check'
  gem 'puppet-lint-absolute_template_path'
  gem 'puppet-lint-no_file_path_attribute-check'
  gem 'puppet-lint-template_file_extension-check'
  gem 'puppet-lint-numericvariable'
  gem 'puppet-lint-appends-check'
  gem 'puppet-lint-class_parameter-check'
  gem 'puppet-lint-world_writable_files-check'
  gem 'puppet-lint-empty_trailing_lines'
  gem 'puppet-lint-empty_lines_around_body-check'
  gem 'puppet-lint-recurse_file-check'
  gem 'puppet-lint-explicit_hiera_class_param_lookup-check'
  gem 'puppet-lint-param-types'
  gem 'brakeman'
  gem 'bundle-audit'
  gem 'fasterer'
  gem 'metadata-json-lint'
  gem 'overcommit'
  gem 'puppet-lint'
  gem 'reek'
  gem 'rubocop', :require => false
  gem 'rubocop-performance' if Gem::Version.new(RUBY_VERSION) > Gem::Version.new('2.3.0')
end

group :unit_test, :acceptance_test, :publish do
  gem 'puppet-catalog_rspec'
  gem 'easy_type_helpers', :git => 'https://github.com/enterprisemodules/easy_type_helpers.git'
  gem 'puppetlabs_spec_helper'
end
