#
# See the file "LICENSE" for the full license governing this code.
#
#  This function checks if an Oracle connection manager is running. It does this by checking
#  in the ora_install_homes fact for conn_mgrs in the running_processes section. If somewhere
#  a connection manager is detected, it returns a true.
#
Puppet::Functions.create_function(:'ora_profile::ocm_running') do
  dispatch :ocm_running do
    return_type 'Boolean'
  end

  def ocm_running
    fact = variable('ora_install_homes')
    fact && fact['running_processes'].any? { |_k, v| v['conn_mgrs'].any? }
  end

  private

  def variable(var)
    return nil unless closure_scope.include?(var)

    closure_scope[var]
  end
end
