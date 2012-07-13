class FeatherCmsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_cms_files
    template 'initializer.rb', 'config/initializers/feather_cms.rb'

    migration_file = Dir.glob("db/migrate/[0-9]*_*.rb").grep(/\d+_create_feather_pages.rb$/).first
    migration_number = if migration_file 
                         migration_file.gsub(/_create_feather_pages.rb|db|migrate|\//, '') 
                       else 
                         Time.now.utc.to_s.gsub(/[- :UTC]/, '')
                       end

    template 'migration.rb', "db/migrate/#{migration_number}_create_feather_pages.rb"
  end

  def add_routes
    feather_routes =
<<-ROUTES

  mount FeatherCms::Engine => "/feathers"

  get 'pages/:name' => 'feather_cms/pages#published', :as => 'feather_published_page'
ROUTES

    route feather_routes
  end

end
