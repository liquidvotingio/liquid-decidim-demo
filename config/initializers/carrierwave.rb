# frozen_string_literal: true

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/linode'                                             # required
  config.fog_credentials = {
    provider:              'Linode',                                             # required
    aws_access_key_id:     ENV["LINODE_BUCKET_KEY_ID"],     # required
    aws_secret_access_key: ENV["LINODE_BUCKET_ACCESS_KEY"], # required
    region:                'default',                                       # optional, defaults to 'us-east-1'
    endpoint:              'https://eu-central-1.linodeobjects.com'                      # optional, defaults to nil
  }
  config.fog_directory  = 'uploads'                                 # required
  config.fog_public     = false                                               # optional, defaults to true
  config.fog_attributes = {
    'Cache-Control' => "max-age=#{365.day.to_i}",
    'X-Content-Type-Options' => "nosniff"
  }
end
