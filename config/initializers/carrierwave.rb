CarrierWave.configure do |config|
  if Rails.env.test?
    CarrierWave.configure do |conf|
      conf.storage = :file
      conf.enable_processing = false
    end
  end

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
    region:                 ENV['AWS_REGION'],
  }
  config.aws_bucket = 'frolflashcards'
end
