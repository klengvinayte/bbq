source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "aws-sdk-s3", require: false
gem "bootsnap", require: false
gem "cssbundling-rails"
gem "devise"
gem "devise-i18n"
gem "dotenv-rails"
gem "font-awesome-rails"
gem "font-awesome-sass", "~> 6.2.1"
gem "image_processing", ">= 1.2"
gem "jbuilder"
gem "jsbundling-rails"
gem "mailjet"
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-rails_csrf_protection'
gem "puma", "~> 5.0"
gem "pundit"
gem "rails", "~> 7.0.4"
gem "rails-i18n"
gem "resque", "~> 2.4"
gem "russian"
gem "rmagick"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.0", ">= 6.0.1"
  gem "factory_bot_rails"
  gem "shoulda-matchers", "~> 5.3"
end

group :development do
  gem "ed25519", '~> 1.3.0'
  gem "bcrypt_pbkdf", '~> 1.1.0'
  gem "capistrano"
  gem "capistrano-rails", '~> 1.6'
  gem 'capistrano-resque', '~> 0.2.3', require: false
  gem "capistrano-passenger"
  gem "capistrano-rbenv", '~> 2.2'
  gem "capistrano-bundler", '~> 2.0'
  gem "letter_opener"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "pg"
end
