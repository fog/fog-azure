require 'fog/azure/version'
require 'fog/azure/core'
require 'fog/azure/compute'

module Fog
  module Azure
    extend Fog::Provider

    service(:compute, 'Compute')
  end

  module Compute
    autoload :azure, 'fog/compute/azure'
  end
end
