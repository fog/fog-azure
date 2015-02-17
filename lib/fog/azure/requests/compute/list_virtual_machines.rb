# Copyright (c) Microsoft Open Technologies, Inc.  All rights reserved.
#
# The MIT License (MIT)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
module Fog
  module Compute
    class Azure
      class Real
        def list_virtual_machines
          @vm_svc.list_virtual_machines
        end
      end

      class Mock
        def list_virtual_machines
          vm = ::Azure::VirtualMachineManagement::VirtualMachine.new
          vm.cloud_service_name = "cool-vm"
          vm.status = "ReadyRole"
          vm.ipaddress = "123.45.67.89"
          vm.vm_name = "cool-vm"
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
          [vm]
        end
      end
    end
  end
end
