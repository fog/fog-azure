module Fog
  module Compute
    class Azure
      class Real
        def add_data_disk(vm_name, cloud_service_name, options)
          @vm_svc.add_data_disk(vm_name, cloud_service_name, options)
        end
      end
    end
  end
end
