require 'bootstrap-sass'

module FeatherCms
  class Engine < ::Rails::Engine
    isolate_namespace FeatherCms
   
    if Rails.version >= '3.1'
      initializer "feather_cms.assets.precompile", :group => :all do |app|
        app.config.assets.precompile += %w(feather_cms/all.* )
      end
    end

  end
end
