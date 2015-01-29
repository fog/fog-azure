
require File.expand_path('../../lib/fog/azure', __FILE__)

Bundler.require(:test)

Excon.defaults.merge!(:debug_request => true, :debug_response => true)

require File.expand_path(File.join(File.dirname(__FILE__), 'helpers', 'mock_helper'))

# This overrides the default 600 seconds timeout during live test runs
if Fog.mocking?
  Fog.timeout = ENV['FOG_TEST_TIMEOUT'] || 2000
  Fog::Logger.warning "Setting default fog timeout to #{Fog.timeout} seconds"
end

