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

    # config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #   :address              => "mxsafe.pge.ce.gov.br",
    #   :port                 => 25,
    #   :domain               => "pge.ce.gov.br",
    #   #:user_name            => "assistente.virtual@pge.ce.gov.br"
    #   #:password             => "av2010",
    #   #:authentication       => :login,
    #   :enable_starttls_auto => true,
    #   :openssl_verify_mode => 'none'
    # }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :user_name => 'db206629333374',
      :password => '815bdd994e06fe',
      :address => 'smtp.mailtrap.io',
      :domain => 'smtp.mailtrap.io',
      :port => '2525',
      :authentication => :cram_md5
    }
  end
end
