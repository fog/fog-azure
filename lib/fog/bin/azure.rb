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
module Azure # deviates from other bin stuff to accomodate gem
  class << self
    def class_for(key)
      case key
      when :compute
        Fog::Compute::Azure
      else
        raise ArgumentError, "Unrecognized service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
        when :compute
          Fog::Logger.warning("Azure[:compute] is not recommended, use Compute[:azure] for portability")
          Fog::Compute.new(:provider => 'Azure')
        else
          raise ArgumentError, "Unrecognized service: #{key.inspect}"
        end
      end
      @@connections[service]
    end

    def available?
      availability = true
      for service in services
        begin
          service = self.class_for(service)
          availability &&= service.requirements.all? { |requirement| Fog.credentials.include?(requirement) }
        rescue ArgumentError => e
          Fog::Logger.warning(e.message)
          availability = false
        rescue => e
          availability = false
        end
      end

      if availability
        for service in services
          for collection in self.class_for(service).collections
            unless self.respond_to?(collection)
              self.class_eval <<-EOS, __FILE__, __LINE__
                def self.#{collection}
                  self[:#{service}].#{collection}
                end
              EOS
            end
          end
        end
      end
      availability
    end

    def collections
      services.map {|service| self[service].collections}.flatten.sort_by {|service| service.to_s}
    end

    def services
      Fog::Azure.services
    end
  end
end
