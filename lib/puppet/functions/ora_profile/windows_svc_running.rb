#
# See the file "LICENSE" for the full license governing this code.
#
#  This function checks if an Oracle Service is running on Windows.
#
Puppet::Functions.create_function(:'ora_profile::windows_svc_running') do
  dispatch :windows_svc_running do
    param 'String[1]', :svc
    return_type 'Boolean'
  end

  def windows_svc_running(svc) # rubocop:disable Naming/PredicateMethod
    service_state = `sc query #{svc}`.scan(/STATE *:.*(RUNNING)/).flatten.first
    service_state == 'RUNNING'
  end
end
