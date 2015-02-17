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
require "fog/compute/models/server"
require "net/ssh/proxy/command"
require "tempfile"

module Fog
  module Compute
    class Azure
      class StorageAccount < Fog::Model
        identity :name
        attribute :url
        attribute :description
        attribute :affinity_group
        attribute :location
        attribute :label
        attribute :status
        attribute :endpoints
        attribute :geo_replication_enabled
        attribute :geo_primary_region
        attribute :status_of_primary
        attribute :last_geo_failover_time
        attribute :geo_secondary_region
        attribute :status_of_secondary
        attribute :creation_time
        attribute :extended_properties


        def save
          requires :name
          requires_one :location, :affinity_group

          options = {
            :label => label,
            :location => location,
            :description => description,
            :affinity_group_name => affinity_group,
            :geo_replication_enabled => geo_replication_enabled,
            :extended_properties => extended_properties,
          }

          service.create_storage_account(name, options)
        end

        def destroy
          requires :name
          service.delete_storage_account(name)
        end
      end
    end
  end
end
