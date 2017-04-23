# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

require 'spec_helper'
require 'rspec/rails'
require 'aasm/rspec'
require 'omniauth'
require 'carrierwave/test/matchers'

ActiveRecord::Migration.maintain_test_schema!
OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ActionDispatch::TestProcess
  config.include CarrierWave::Test::Matchers
  config.include I18n
  config.include FeatureHelper, type: :feature
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
