#
# See the file "LICENSE" for the full license governing this code.
#
# This function returns the OPatch zipfile and OPatch version if specified in a Hash.
#
Puppet::Functions.create_function(:'ora_profile::get_opatch_details') do
  dispatch :get_opatch_details do
    param 'Variant[String[1], Hash]', :patch_file
    param 'String',                   :oracle_home
    param 'String',                   :opversion
    return_type 'Struct[{ patch_file => String[1], opversion => String[1] }]'
  end

  def get_opatch_details(patch_file, oracle_home, opversion)
    return { 'patch_file' => "#{patch_file}.zip", 'opversion' => opversion } if patch_file.is_a?(String)
    return { 'patch_file' => 'n/a', 'opversion' => 'n/a' } if patch_file.dig(oracle_home, 'patch_file').nil?

    if patch_file.dig(oracle_home, 'opversion').nil?
      { 'patch_file' => "#{patch_file[oracle_home]['patch_file']}.zip",
        'opversion' => opversion }
    else
      { 'patch_file' => "#{patch_file[oracle_home]['patch_file']}.zip",
        'opversion' => patch_file[oracle_home]['opversion'] }
    end
  end
end
