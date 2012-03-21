class FeatherCmsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :attributes, :type => :array, :banner => "about_us jobs"
  argument :name, :type => :string, :default => "feather_cms", :required => false 
  argument :storage, :type => :string , :default => 'file'

  #PAGES = ['about_us']

  def create_cms_files
    @pages = attributes.collect(&:name)

    unless ['file', 'db'].include?(storage)
      puts "Valid storaage type are db,file"
      storaage = 'file'
    end
    @storaage = storaage

    template 'initializer.rb', 'config/initializers/feather_cms.rb'
    template 'controller.rb', 'app/controllers/feathers_controller.rb'
    template 'model.rb', 'app/models/feather_page.rb'

    migration_file = Dir.glob("db/migrate/[0-9]*_*.rb").grep(/\d+_create_feather_pages.rb$/).first
    migration_number = if migration_file 
                         migration_file.gsub(/_create_feather_pages.rb|db|migrate|\//, '') 
                       else 
                         Time.now.utc.to_s.gsub(/[- :UTC]/, '')
                       end

    template 'migration.rb', "db/migrate/#{migration_number}_create_feather_pages.rb"

    route_str =  "scope '/feathers' do \n"
    @pages.each do |action|
      route_str << %{    match '#{action}_page/(:status)' => 'feathers##{action}', :as => :feather_#{action} \n}
    end
    route_str << "  end"
    route route_str
  end

  def copy_view_files
    @pages = attributes.collect(&:name)
    base_path = File.join("app/views/feathers")
    empty_directory base_path

    @pages.each do |action|
      @action = action
      @path = File.join(base_path, "#{action}.html.erb")
      template 'form.html.erb', @path
    end
  end

  def add_static_files
    if Rails.version > '3.0.9'
      directory 'codemirror', 'app/assets/codemirror'
    else
      directory 'codemirror', 'public/codemirror'
    end
  end



end
