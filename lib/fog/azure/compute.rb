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
require "fog/azure/core"

module Fog
  module Compute
    class Azure < Fog::Service
      requires  :azure_sub_id
      requires  :azure_pem

      recognizes  :azure_api_url

      request_path "fog/azure/requests/compute"
      request :list_virtual_machines
      request :create_virtual_machine
      request :delete_virtual_machine
      request :get_storage_account
      request :create_storage_account
      request :list_storage_accounts
      request :delete_storage_account
      request :reboot_server
      request :shutdown_server
      request :start_server
      request :list_images
      request :list_databases
      request :create_database_server
      request :delete_database
      request :firewall_rules
      request :add_data_disk

      model_path "fog/azure/models/compute"
      model :server
      collection :servers
      model :storage_account
      collection :storage_accounts
      model :image
      collection :images
      model :database
      collection :databases

      class Mock
        def initialize(options={})
          begin
            require "azure"
          rescue LoadError => e
            retry if require("rubygems")
            raise e.message
          end
        end
      end

      class Real
        def initialize(options)
          begin
            require "azure"
          rescue LoadError => e
            retry if require("rubygems")
            raise e.message
          end
          ::Azure.configure do |cfg|
            cfg.management_certificate = options[:azure_pem]
            cfg.subscription_id = options[:azure_sub_id]
            cfg.management_endpoint = options[:azure_api_url] || \
              "https://management.core.windows.net"
          end
          @vm_svc = ::Azure::VirtualMachineManagementService.new
          @stg_svc = ::Azure::StorageManagementService.new
          @image_svc = ::Azure::VirtualMachineImageManagementService.new
          @db_svc = ::Azure::SqlDatabaseManagementService.new
        end
      end
    end
  end
end
