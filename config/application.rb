require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application

    config.paths['config/database'] = config.root + '../server-shared/config/database.yml'
    config.paths['config/secrets'] = config.root + '../server-shared/config/secrets.yml'
    config.paths['app/models'] << config.root + '../server-shared/app/models'
    config.paths['db'] << config.root + '../server-shared/db'
    config.paths['db/migrate'] << config.root + '../server-shared/db/migrate'
    config.paths['db/seeds.rb'] << config.root + '../server-shared/db/seeds.rb'

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'CET'
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.exceptions_app = self.routes
    config.api_only = false

    config.beginning_of_week = :monday
  end
end
