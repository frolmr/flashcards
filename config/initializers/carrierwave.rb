CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'] || 'test',
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || 'test',
    region:                ENV['REGION'] || 'test'
  }
  config.fog_directory  = ENV['FOLDER'] || 'test'
  config.fog_public     = false
end
