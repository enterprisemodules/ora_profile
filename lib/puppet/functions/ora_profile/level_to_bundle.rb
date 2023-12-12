#
# See the file "LICENSE" for the full license governing this code.
#
# This function determines the patch bundle id based on the specified level.
#
# There are no checks for validity in this code, because it is **ALWAYS** called **AFTER**
# `ora_profile::level_to_bundle`, that does all the checking.
#
# In contrast with level_to_patches, this function doesn't support a Hash level. That is
# because we don't support multiple grid versions on 1 system.
#
Puppet::Functions.create_function(:'ora_profile::level_to_bundle') do
  dispatch :level_to_bundle do
    param 'Optional[String[1]]',    :level
    param 'Optional[String[1]]',    :version
    return_type 'String'
  end

  def level_to_bundle(level, version)
    return 'n/a' if level.nil? || level == 'NONE'

    db_patch_levels[version][level].keys.first
  end

  def db_patch_levels
    @db_patch_levels ||= call_function('lookup', 'ora_profile::database::patch_levels', data_type('Hash'), 'first')
  end

  def data_type(string)
    parser = Puppet::Pops::Types::TypeParser.singleton
    parser.parse(string)
  end
end
