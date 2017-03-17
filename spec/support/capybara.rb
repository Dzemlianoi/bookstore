require 'capybara/rails'
require 'capybara/rspec'
# require 'capybara/poltergeist'
RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.javascript_driver = :selenium
Capybara.default_driver = :selenium