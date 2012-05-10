class FeatherCmsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :attributes, :type => :array, :banner => "about_us jobs"
  class_option :storage, :aliases => '-t', :type => :string, :desc => 'db or file storage.'

  def create_cms_files
    @storage = ['file', 'db'].include?(options['storage']) ? options['storage'] : 'file'

    template 'initializer.rb', 'config/initializers/feather_cms.rb'
    template 'controller.rb',  'app/controllers/feathers_controller.rb'
    template 'model.rb',       'app/models/feather_page.rb'
    template 'helper.rb',      'app/helpers/feathers_helper.rb'

    migration_file = Dir.glob("db/migrate/[0-9]*_*.rb").grep(/\d+_create_feather_pages.rb$/).first
    migration_number = if migration_file 
                         migration_file.gsub(/_create_feather_pages.rb|db|migrate|\//, '') 
                       else 
                         Time.now.utc.to_s.gsub(/[- :UTC]/, '')
                       end

    template 'migration.rb', "db/migrate/#{migration_number}_create_feather_pages.rb"
  end

  def add_routes
    feather_route =  
<<-ROUTES

  scope '/feathers' do
    match 'page/:type/(:status)' => 'feathers#page', :as => :feather_page
    get 'pages' => 'feathers#index', :as => :feather_pages
    get 'preivew/:type/(:status)' => 'feathers#preivew', :as => 'feather_page_preview'
  end
  get 'page/:type' => 'feathers#published', :as => 'feather_published_page'
ROUTES

    route feather_route
  end

  def copy_view_files
    @pages = attributes
    base_path = File.join("app/views/feathers")
    #empty_directory base_path
    template 'layout.html.erb', 'app/views/layouts/feather_layout.html.erb'
    template 'index.html.erb', File.join(base_path, 'index.html.erb')

    @pages.each do |type|
      @type = type
      @path = File.join(base_path, "#{type}.html.erb")
      template 'form.html.erb', @path
    end
  end

  def add_static_files
    if Rails.version > '3.0.9'
      directory 'codemirror', 'app/assets/codemirror'
      copy_file "bootstrap.css", 'app/assets/stylesheets/bootstrap.css' 
    else
      directory 'codemirror', 'public/codemirror'
      copy_file "bootstrap.css", 'public/stylesheets/bootstrap.css' 
    end
  end

end
