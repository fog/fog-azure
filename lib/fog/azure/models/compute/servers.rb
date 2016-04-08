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
require "fog/core/collection"
require "fog/azure/models/compute/server"

module Fog
  module Compute
    class Azure
      class Servers < Fog::Collection
        model Fog::Compute::Azure::Server

        def all(options = {})
          servers = []
          service.list_virtual_machines.each do |vm|
            hash = {}
            vm.instance_variables.each do |var|
              hash[var.to_s.delete("@")] = vm.instance_variable_get(var)
            end
            hash[:vm_user] = "azureuser" if hash[:vm_user].nil?
            servers << hash
          end
          load(servers)
        end

        def get(identity, cloud_service_name)
          all.find { |f| f.name == identity && f.cloud_service_name == cloud_service_name }
        rescue Fog::Errors::NotFound
          nil
        end

        def bootstrap(new_attributes = {})
          defaults = {
            :vm_name => "fog-#{Time.now.to_i}",
            :vm_user => "azureuser",
            :image => "b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-12_04_3-LTS-amd64-server-20131205-en-us-30GB",
            :location => "Central US",
            :private_key_file => File.expand_path("~/.ssh/id_rsa"),
            :vm_size => "Small",
          }

          server = create(defaults.merge(new_attributes))
          server.wait_for { sshable? } unless server.private_key_file.nil?
          server
        end
      end
    end
  end
end
