CarrierWave.configure do |config|
  if Rails.env.production?
    config.dropbox_app_key = ENV['app_key']
    config.dropbox_app_secret = ENV['app_secret']
    config.dropbox_access_token = ENV['access_token']
    config.dropbox_access_token_secret = ENV['access_token_secret']
    config.dropbox_user_id = ENV['user_id']
    config.dropbox_access_type = 'dropbox'
    config.storage = :dropbox
  end
end