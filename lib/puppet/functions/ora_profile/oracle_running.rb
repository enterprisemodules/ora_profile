#
# See the file "LICENSE" for the full license governing this code.
#
# This function checks if an instance of Oracle is running. It does this by checking
# for the fact ora_version. This fict is **ony** filled when at least one database instance
# is running
#
Puppet::Functions.create_function(:'ora_profile::oracle_running') do
  dispatch :oracle_running do
    return_type 'Boolean'
  end

  def oracle_running
    !!variable('ora_version')
  end

  private

  def variable(var)
    return nil unless closure_scope.include?(var)

    closure_scope[var]
  end
end
