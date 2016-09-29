CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    # aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    # aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    # region:                ENV['REGION']
    aws_access_key_id: 'test',
    aws_secret_access_key: 'test-test',
    region: 'mordor'
  }
  # config.fog_directory  = ENV['FOLDER']
  config.fog_directory = 'trash'
  config.fog_public     = false
end
