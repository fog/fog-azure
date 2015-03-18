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
Shindo.tests("Fog::Compute[:azure] | database model", ["azure", "compute"]) do

  service = Fog::Compute[:azure]

  tests("The database model should") do
    db  = service.databases.all.first
    puts "The database class: #{db.class}"
    tests("have the actions") do
      test("destroy") { db.respond_to? "destroy" }
      test("firewall_rules") { db.respond_to? "firewall_rules" }
    end

    tests("have attributes") do
      model_attribute_hash = db.attributes
      attributes = [
        :name,
        :feature_name,
        :feature_value,
        :location,
        :administrator_login
      ]
      tests("The database model should respond to") do
        attributes.each do |attribute|
          test("#{attribute}") { db.respond_to? attribute }
        end
      end
    end
  end
end
