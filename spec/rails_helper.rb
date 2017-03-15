ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'spec_helper'
require 'rspec/rails'
require 'omniauth'
require 'capybara/rspec'
require 'carrierwave/test/matchers'
require 'aasm/rspec'
require 'with_model'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ActionDispatch::TestProcess
  config.include Warden::Test::Helpers
  config.include CarrierWave::Test::Matchers
  config.include I18n
  config.extend WithModel
  config.include Capybara::DSL

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  Capybara.default_driver = :selenium
  Capybara.javascript_driver = :selenium

  config.use_transactional_fixtures = false
  OmniAuth.config.test_mode = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end