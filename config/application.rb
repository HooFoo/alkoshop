require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AlkoShop
  class Application < Rails::Application
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ['ru']
    config.i18n.default_locale = :ru
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.precompile += Ckeditor.assets
    config.active_job.queue_adapter = :delayed_job
  end
end
