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
Puppet::Functions.create_function(:'ora_profile::level_to_messages') do
  dispatch :level_to_messages do
    param 'Variant[Undef, String[1],Hash]', :level
    param 'Boolean',                        :include_ojvm
    param 'Hash',                           :patch_list
    param 'Optional[String[1]]',            :oracle_home
    param 'Optional[String[1]]',            :version
    return_type 'Variant[String[1],Array[String]]'
  end

  def level_to_messages(level, include_ojvm, patch_list, oracle_home, version)
    case level
    when nil
      []
    when String
      handle_string_level(level, include_ojvm, patch_list, oracle_home, version)
    when Hash
      handle_hash_level(level, include_ojvm, patch_list).compact
    else
      fail 'Invalid level type specified'
    end
  end

  private

  def handle_string_level(level, include_ojvm, patch_list, oracle_home, version)
    return "Ensure DB Patch(es) #{patch_list.keys.join(',')} on ${oracle_home}" if level == 'NONE' && !patch_list.keys.empty?
    return [] if level == 'NONE'

    ojvm_msg = if include_ojvm && Gem::Version.new(version) < Gem::Version.new('21.0.0.0')
                 ' including OJVM'
               else
                 ''
               end

    if patch_list.keys.empty?
      "Ensure DB patch level #{level}#{ojvm_msg} on #{oracle_home}"
    else
      "Ensure DB patch level #{level}#{ojvm_msg} on #{oracle_home} and patch list #{patch_list.keys.join(',')}"
    end
  end

  def handle_hash_level(levels, include_ojvm, patch_list)
    levels.reduce([]) do |result, definitions|
      oracle_home = definitions.last['oracle_home']
      level = definitions.last['level'] || 'NONE'
      version = definitions.last['version'] || db_version
      result << handle_string_level(level, include_ojvm, patch_list, oracle_home, version)
    end
  end
end
