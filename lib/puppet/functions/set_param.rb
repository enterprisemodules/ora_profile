#
# See the file "LICENSE" for the full license governing this code.
#
# Returns the value for requested parameter.
# Currently supported parameters:
# - instance_name
# - instance_number
# - thread_number
#

Puppet::Functions.create_function(:set_param) do
  dispatch :set_string_param do
    param 'String', :param_name
    param 'String', :dbname
    optional_param 'Undef', :cluster_nodes
    return_type 'String'
  end

  dispatch :set_string_param_cluster do
    param 'String', :param_name
    param 'String', :dbname
    param 'Array', :cluster_nodes
    # return_type 'String'
  end

  def set_string_param(param_name, dbname, _cluster_nodes)
    case param_name
    when 'instance_name'
      return_value = dbname
    when 'instance_number', 'thread_number'
      return_value = ''
    else
      fail "Unknown param_name #{param_name}"
    end
    return_value
  end

  def set_string_param_cluster(param_name, dbname, cluster_nodes)
    scope = closure_scope
    hostname = scope['networking']['hostname']
    case param_name
    # instance_name
    when 'instance_name'
      if cluster_nodes && dbname
        index = 0
        instance_number = cluster_nodes.map do |node|
          index += 1
          index if node == hostname
        end
        return_value = "#{dbname}#{instance_number.flatten.join}"
      elsif dbname
        return_value = dbname
      else
        fail "cluster_nodes and/or dbname needed to determine value for #{param_name}"
      end
    # instance_number and thread_number
    when 'instance_number', 'thread_number'
      if cluster_nodes && dbname
        index = 0
        instance_number = cluster_nodes.map do |node|
          index += 1
          index if node == hostname
        end
        return_value = instance_number.flatten.join
      elsif dbname
        return_value = ''
      else
        fail "cluster_nodes and dbname needed to determine value for #{param_name}"
      end

    else
      fail "Unknown param_name #{param_name}"
    end
    return_value
  end
end
# rubocop: enable Metrics/AbcSize
# rubocop: enable Metrics/CyclomaticComplexity
# rubocop: enable Metrics/PerceivedComplexity
# rubocop: enable Metrics/MethodLength
