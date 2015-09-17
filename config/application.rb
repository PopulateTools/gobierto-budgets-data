require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "csv"

Bundler.require(*Rails.groups)

module GobifyData
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
  end
end
