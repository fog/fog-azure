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

def azure_service
  Fog::Compute[:azure]
end

def vm_attributes
  image = azure_service.images.select{|image| image.os_type == "Linux"}.first
  location = image.locations.split(";").first

  {
    :image  => image.name,
    :location => location,
    :vm_name => vm_name,
    :vm_user => "foguser",
    :password =>  "ComplexPassword!123",
    :storage_account_name => storage_name
  }
end

def vm_name
  "fog-test-server"
end

def storage_name
  "fogteststorageaccount"
end

def fog_server
  server = azure_service.servers.select { |s| s.vm_name == vm_name }.first
  unless server
    server = azure_service.servers.create(
      vm_attributes
    )
  end
  server
end

def storage_account
  storage = azure_service.storage_accounts.select { |s| s.name == storage_name }.first
  unless storage
    storage = azure_service.storage_accounts.create(
      {:name => storage_name, :location => "West US"}
    )
  end
  azure_service.storage_accounts.get(storage_name)
end

def vm_destroy
  server = azure_service.servers.select { |s| s.vm_name == vm_name }.first
  server.destroy if server
end

def storage_destroy
  storage = azure_service.storage_accounts.select { |s| s.name == storage_name }.first
  storage.destroy if storage
end

def database_destroy
  db = azure_service.databases.select {|s| s.name == database_name }.first
  db.delete
end

at_exit do
  unless Fog.mocking?
    storage_destroy
    vm_destroy
  end
end
