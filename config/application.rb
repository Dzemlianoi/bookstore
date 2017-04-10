# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)

class Bookstore::Application < Rails::Application
end
