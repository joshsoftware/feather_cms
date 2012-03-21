require 'rails'

module FeatherCms
  module Railtie
    class Railtie < ::Rails::Railtie
      if ::Rails.version.to_f >= 3.1
        config.before_configuration do |app|
          app.config.assets.paths << Rails.root.join("app", "assets", "codemirror")
        end
      end
    end
  end
end
