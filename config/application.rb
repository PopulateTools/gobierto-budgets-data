require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "csv"

Bundler.require(*Rails.groups)

module GobifyData
  class Application < Rails::Application
  end
end
