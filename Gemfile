source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"

gem 'mongoid', '~> 8.0'
gem 'tiny_tds'
gem 'activerecord-sqlserver-adapter'
gem 'sidekiq'
gem 'sinatra'
gem "redis", "~> 5.3"
gem 'rack'
gem 'rack-cors', require: 'rack/cors'
gem 'activerecord-import'
gem 'will_paginate', '~> 3.3'
gem 'spring'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem 'pry'
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 5.0.0"
end

group :development, :test do
  gem "factory_bot_rails"
end

group :development, :test do
  gem "faker"
end

group :test do
  gem "capybara"
end

group :test do
  gem "database_cleaner-active_record"
  gem "database_cleaner-mongoid"
end
