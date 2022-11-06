require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AtivosPge
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ["pt-BR"]
    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'America/Fortaleza'

    # Set as default hellpers in system
    config.action_controller.include_all_helpers = true

  end
end
