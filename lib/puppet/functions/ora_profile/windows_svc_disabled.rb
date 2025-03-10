#
# See the file "LICENSE" for the full license governing this code.
#
#  This function checks if an Oracle Service is disabled on Windows.
#
Puppet::Functions.create_function(:'ora_profile::windows_svc_disabled') do
  dispatch :windows_svc_disabled do
    param 'String[1]', :svc
    return_type 'Boolean'
  end

  def windows_svc_disabled(svc) # rubocop:disable Naming/PredicateMethod
    service_state = `sc qc #{svc}`.scan(/START_TYPE *:.*(DISABLED)/).flatten.first
    service_state == 'DISABLED'
  end
end
