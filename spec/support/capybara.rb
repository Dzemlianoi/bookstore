require 'capybara/rails'
require 'capybara/rspec'
byebug
# require 'capybara/poltergeist'
RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.javascript_driver = :selenium_chrome