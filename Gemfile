# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'bootsnap', require: false
gem 'devise'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pagy'
gem 'pg'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'redis'
gem 'sidekiq'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'dockerfile-rails', '>= 1.6'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'pundit-matchers'
  gem 'rails-controller-testing'
  gem 'rspec-enqueue_sidekiq_job', require: false
  gem 'rspec_junit_formatter'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'simplecov-cobertura'
  gem 'super_diff'
  gem 'webdrivers'
  gem 'webmock'
end
