Devise.setup do |config|
  require 'devise/orm/active_record'
  config.mailer_sender = 'Bookstore@bookstore.com'
  config.mailer_sender = 'Bookstore@bookstore.com'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.omniauth :facebook, '206306006502670', 'b0f1e0ab0ca6bc8ab10ce3457c202b48'
end
