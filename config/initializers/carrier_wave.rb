require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'                        # required
  config.fog_public = true
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),     # required unless using use_iam_profile
    aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
    region:                'ap-northeast-1',               # optional, defaults to 'us-east-1'
    path_style: true
  }
  config.fog_directory  = Rails.application.credentials.dig(:aws, :s3_bucket_name)              # required
end