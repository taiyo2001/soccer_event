source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'sprockets-rails'

gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

gem 'i18n_generators'
gem 'jbuilder'
gem 'kaminari'
gem 'tailwindcss-rails'

gem 'enumerize'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # for sample data
  gem 'faker'
  gem 'forgery_ja'
  gem 'gimei'

  # Code Analyze
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'erb_lint'
  gem 'htmlbeautifier'
  gem 'rails_best_practices', require: false
  gem 'rubocop'

  # Debugger
  gem 'better_errors'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rspec_junit_formatter'

  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'letter_opener_web'
  gem 'rails-erd'
end

group :development do
  gem 'web-console'

  gem 'activerecord-import'
  gem 'rack-mini-profiler'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem 'devise'

gem 'dockerfile-rails', '>= 1.6', group: :development
