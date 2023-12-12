#
# See the file "LICENSE" for the full license governing this code.
#
# This function translates the possible ways of specifying the patches in a universal output that can be processed by ora_opatdh.
# The ways are:
# 1) Specifying an Oracle home and and a patch level string. In this case The content (e.g. the patches in this level)of the level is looked up
#    and applied to the specified Oracle home.
#
# 2) The patch level contains a Hash with the designated oracle home and a patch level:
#     ```
#     {
#       '/oracle_home_1':   'LEVEL_1'
#       '/oracle_home_2':   'LEVEL_2'
#     ```
#
Puppet::Functions.create_function(:'ora_profile::level_to_patches') do
  dispatch :level_to_patches do
    param 'Variant[Undef, String[1],Hash]',       :level
    param 'String[1]',                            :source
    param 'String[1]',                            :opversion
    param 'Optional[String[1]]',                  :oracle_home
    param 'Optional[String[1]]',                  :version
    param 'Optional[Enum["ojvm", "db","grid"]]',  :patch_type
    return_type 'Hash'
  end

  def level_to_patches(level, source, opversion, oracle_home, version, patch_type = 'db')
    case level
    when String
      handle_string_level(level, source, opversion, oracle_home, version, patch_type)
    when Hash
      handle_hash_level(level, source, opversion, patch_type)
    else
      fail 'Invalid level type specified'
    end
  end

  private

  def handle_string_level(level, source, opversion, oracle_home, version, patch_type)
    return {} if level.nil? || level == 'NONE'

    validate_oracle_home(oracle_home)
    # No way to really validate source so, we assume it is valid.

    case patch_type
    when 'ojvm'
      validate_level(level, version, ojvm_patch_levels)
      map_ojvm_level_to_resource(level, source, opversion, oracle_home, version, ojvm_patch_levels)
    when 'db', 'grid'
      validate_level(level, version, db_patch_levels)
      map_db_level_to_resource(level, source, opversion, oracle_home, version, patch_type, db_patch_levels)
    else
      fail "Patch type #{patch_type} is unknown."
    end
  end

  def handle_hash_level(levels, source, opversion, patch_type)
    levels.reduce({}) do |result, definitions|
      oracle_home = definitions.last['oracle_home']
      level = definitions.last['level'] || 'NONE'
      version = definitions.last['version'] || db_version
      result.merge(handle_string_level(level, source, opversion, oracle_home, version, patch_type))
    end
  end

  def map_ojvm_level_to_resource(level, _source, opversion, oracle_home, version, patch_definitions)
    patch_definitions[version][level].reduce({}) do |result, entry|
      patch_entry = Hash[*entry]
      validate_opatch_level(entry, opversion)
      patch_name = patch_entry.keys.first
      patch_number = patch_name.split(':').last
      value = patch_entry[patch_name]
      result.merge!({ "#{oracle_home}:#{patch_number}" => value })
    end
  end

  def map_db_level_to_resource(level, source, opversion, oracle_home, version, patch_type, patch_definitions)
    patch_definitions[version][level].reduce({}) do |result, entry|
      patch_name, patch_data = entry
      validate_patch_entry(entry, patch_type)
      validate_opatch_level(entry, opversion)
      sub_patches = patch_data["#{patch_type}_sub_patches"]
      full_source = "#{source}/#{patch_data['file']}"
      patch_data = patch_data.dup
      case patch_type
      when 'db'
        keys_to_remove = %w[db_sub_patches grid_sub_patches file type required_opversion]
      when 'grid'
        patch_data['type'] = 'psu' if patch_data['type'].nil?
        keys_to_remove = %w[db_sub_patches grid_sub_patches file required_opversion]
      end
      keys_to_remove.each { |k| patch_data.delete(k) }
      value = patch_data.merge({ 'source' => full_source, 'sub_patches' => sub_patches })
      sub_patches.any? ? result.merge({ "#{oracle_home}:#{patch_name}" => value }) : result
    end
  end

  def validate_patch_entry(patch_entry, patch_type)
    patch_name, patch_data = patch_entry
    return if patch_type == 'ojvm'

    fail "patch_levels Hash is missing '#{patch_type}_sub_patches' key for patch #{patch_name}" unless patch_data.key?("#{patch_type}_sub_patches")
    fail "patch_levels Hash is missing 'file' key for patch #{patch_name}" unless patch_data.key?('file')

    return unless patch_type == 'grid'
    fail "wrong 'type' specified for patch_levels patch #{patch_name}, '#{patch_data['type']}' given, expected 'psu' or 'one-off'" if patch_data['type'] && !%w[psu
                                                                                                                                                                oneoff].include?(patch_data['type'])
  end

  def validate_opatch_level(patch_entry, opversion)
    patch_name, patch_data = patch_entry
    return unless patch_data.key?('required_opversion')
    return unless Gem::Version.new(opversion) < Gem::Version.new(patch_data['required_opversion'])

    fail("Used Opatch version (#{opversion}) is lower than required Opatch version #{patch_data['required_opversion']} for patch level #{patch_name}")
  end

  def validate_oracle_home(oracle_home)
    fail 'Invalid oracle_home specified' if oracle_home.nil? || oracle_home.empty?
  end

  def validate_level(level, version, definition)
    fail "Level '#{level}' not defined for Oracle version #{version}." unless level_exists?(level, version, definition)
  end

  def level_exists?(level, version, definition)
    definition[version]&.keys&.include?(level)
  end

  def db_patch_levels
    @db_patch_levels ||= call_function('lookup', 'ora_profile::database::patch_levels', data_type('Hash'), 'first')
  end

  def ojvm_patch_levels
    @ojvm_patch_levels ||= call_function('lookup', 'ora_profile::database::db_patches::ojvm_patch_levels', data_type('Hash'), 'first')
  end

  def db_version
    @db_version ||= call_function('lookup', 'ora_profile::database::db_software::version', data_type('Hash'), 'first')
  end

  def data_type(string)
    parser = Puppet::Pops::Types::TypeParser.singleton
    parser.parse(string)
  end
end
#  rubocop:enable Metrics/ParameterLists
