require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MarketplaceV1
  class Application < Rails::Application
    config.load_defaults 8.1

    # Add modules folder to autoload and eager load
    config.autoload_paths << Rails.root.join("app/modules")
    config.eager_load_paths << Rails.root.join("app/modules")

    # Ignore non-Ruby lib folders
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
