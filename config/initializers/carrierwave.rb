CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  if Rails.env.production?
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
      region:                'ap-northeast-1'
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  else
    config.storage :file
  end
end
