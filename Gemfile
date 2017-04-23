# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'aasm', '~> 4.11', '>= 4.11.1'
gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'cancancan'
gem 'carrierwave'
gem 'cloudinary'
gem 'coffee-rails', '~> 4.2'
gem 'countries'
gem 'country_select', '~> 2.1.0'
gem 'devise', '~> 4.2.0'
gem 'draper', '3.0.0.pre1'
gem 'ffaker', '~> 2.4.0'
gem 'figaro'
gem 'font-awesome-rails'
gem 'haml'
gem 'html2haml'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-facebook'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'rails_admin', '~> 1.0'
gem 'rails_admin_aasm'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
gem 'uglifier', '>= 1.3.0'
gem 'wicked'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'capybara-email'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'letter_opener_web'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
