source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'ffaker', '~> 2.4.0'
gem 'wicked'

gem 'devise', '~> 4.2.0'
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-facebook'
gem 'cancancan'
gem 'figaro'
gem 'kaminari'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'

gem 'haml'
gem 'html2haml'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-rails'
gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'
gem 'draper', '3.0.0.pre1'

gem 'rails_admin', '~> 1.0'
gem 'countries'
gem 'country_select', '~> 2.1.0'
gem 'aasm', '~> 4.11', '>= 4.11.1'
gem 'rails_admin_aasm'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'rails-controller-testing'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'capybara-email'
  gem 'letter_opener_web'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
