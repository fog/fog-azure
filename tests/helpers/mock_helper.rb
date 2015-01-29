# Use so you can run in mock mode from the command line
#
# FOG_MOCK=true fog

if ENV["FOG_MOCK"] == "true"
  Fog.mock!
end

# if in mocked mode, fill in some fake credentials for us
if Fog.mock?
  Fog.credentials = {
    :azure_sub_id                     => 'azure_sub_id',
    :azure_pem                        => 'path_of_pem'
  }.merge(Fog.credentials)
end
