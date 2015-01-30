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
Shindo.tests("Fog::Compute[:azure] | server model", ["azure", "compute"]) do

  server = fog_server

  tests("The server model should") do
    pending if Fog.mocking?
    tests("have the action") do
      test("reload") { server.respond_to? "reload" }
      %w{
        destroy
        reboot
        shutdown
        start
      }.each do |action|
        test(action) { server.respond_to? action }
      end
    end

    tests("have attributes") do
      attributes = [
        :vm_name,
        :status,
        :ipaddress,
        :cloud_service_name,
        :image,
        :location,
        :os_type,
        :storage_account_name
      ]
      tests("The server model should respond to") do
        attributes.each do |attribute|
          test("#{attribute}") { server.respond_to? attribute }
        end
      end
    end

    test("#reboot") do
      server.reboot
      server = fog_server
      %w(ReadyRole Provisioning RoleStateUnknown).include?  server.status
    end

    test("#start") do
      server.start
      server = fog_server
      status = %w(ReadyRole Provisioning RoleStateUnknown)
      status.include?  server.status
    end

    test("#shutdown") do
      server.shutdown
      server = fog_server
      %w(StoppedVM StoppedDeallocated).include?  server.status
    end

    test("#destroy") do
      server.destroy
      server = azure_service.servers.select { |s| s.vm_name == vm_name }.first
      server.nil?
    end
  end

end
