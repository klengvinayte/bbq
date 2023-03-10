require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bbq
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.generators.test_framework false
    # config.generators.system_tests = nil

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :en

    config.action_mailer.delivery_method = :mailjet

    config.generators do |g|
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
