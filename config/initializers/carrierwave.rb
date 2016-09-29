CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'] || 'travis test',
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || 'travis test',
    region:                ENV['REGION'] || 'travis test'
  }
  config.fog_directory  = ENV['FOLDER'] || 'travis test'
  config.fog_public     = false
end
if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
