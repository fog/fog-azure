module Fog
  module Compute
    class Azure
      class Real
        def get_virtual_machine(name, cloud_service_name)
          @vm_svc.get_virtual_machine(name, cloud_service_name)
        end
      end

      class Mock
        def get_virtual_machine(name, cloud_service_name)
          vm = ::Azure::VirtualMachineManagement::VirtualMachine.new
          vm.cloud_service_name = cloud_service_name
          vm.status = "ReadyRole"
          vm.ipaddress = "123.45.67.89"
          vm.vm_name = name
          vm.udp_endpoints = []
          vm.hostname = "cool-vm"
          vm.deployment_name = "cool-vm"
          vm.deployment_status = "Running"
          vm.tcp_endpoints = [
            {"Name"=>"http", "Vip"=>"123.45.67.89", "PublicPort"=>"80", "LocalPort"=>"80"},
            {"Name"=>"SSH", "Vip"=>"123.45.67.89", "PublicPort"=>"22", "LocalPort"=>"22"}
          ]
          vm.role_size = "Medium"
          vm.os_type = "Linux"
          vm.disk_name = "cool-vm-cool-vm-0-20130207005053"
          vm.virtual_network_name = ""
          vm.image = "ImageName"
          vm
        end
      end
    end
  end
end
