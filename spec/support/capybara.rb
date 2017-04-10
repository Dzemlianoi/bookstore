# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.ignore_hidden_elements = false
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
