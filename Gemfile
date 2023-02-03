source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4"

gem "devise"
gem "devise-i18n"
gem 'dotenv-rails'
gem "russian"
gem "rails-i18n"
gem "font-awesome-rails"
gem "font-awesome-sass", "~> 6.2.1"
gem "rmagick"
gem "image_processing", ">= 1.2"
gem "aws-sdk-s3", require: false
gem "mailjet"

gem "sprockets-rails"

gem "puma", "~> 5.0"

gem "jsbundling-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "cssbundling-rails"

gem "jbuilder"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
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
