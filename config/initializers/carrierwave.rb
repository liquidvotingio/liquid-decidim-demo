# frozen_string_literal: true

if ENV["LINODE_BUCKET_KEY_ID"].present?
  require "carrierwave/storage/fog"

  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',                           # required
      aws_access_key_id:     ENV["LINODE_BUCKET_KEY_ID"],     # required
      aws_secret_access_key: ENV["LINODE_BUCKET_ACCESS_KEY"], # required
      region:                'default',                       # optional, defaults to 'us-east-1'
      endpoint:              'https://eu-central-1.linodeobjects.com' # optional, defaults to nil
    }
    config.fog_directory  = 'liquid-decidim-demo'             # required
    config.fog_attributes = {
      'Cache-Control' => "max-age=#{365.day.to_i}",
      'X-Content-Type-Options' => "nosniff"
    }
  end
else
  CarrierWave.configure do |config|
    config.permissions = 0o666
    config.directory_permissions = 0o777
    config.storage = :file
    config.enable_processing = !Rails.env.test?
  end
end
