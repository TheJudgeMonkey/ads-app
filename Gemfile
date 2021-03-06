# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'aasm', '~> 5.2.0'
gem 'after_commit_everywhere', '~> 1.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bullet', '~> 6.1.5', '>= 6.1.5'
gem 'cloudinary', '~> 1.21.0'
gem 'devise', '~> 4.8.0'
gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap5'
gem 'enumerize', '~> 2.4.0'
gem 'kaminari', git: 'https://github.com/kaminari/kaminari', ref: '73b93405b95615b5ad3f53c3dffe419a59890cad'
gem 'pundit', '~> 2.1.1', '>= 2.1.1'
gem 'ransack', '~> 2.4.2', '>= 2.4.2'
gem 'rubocop', '~> 1.20.0', require: false
gem 'rubocop-rails', '~> 2.11.3', require: false
gem 'rubocop-rspec', '~> 2.4.0', require: false
gem 'sidekiq', '~> 6.2.2', '>= 6.2.2'
gem 'simple_form', '~> 5.1.0'
gem 'slim-rails', '~> 3.3.0'
gem 'whenever', '~> 1.0.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot', '~> 6.2.0'
  gem 'ffaker', '~> 2.19.0'
  gem 'pry', '~> 0.13.1'
  gem 'rails-controller-testing', '~> 1.0.5', '>= 1.0.5'
  gem 'rspec-its', '~> 1.3.0'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
