FeatherCms::Config.init do |c|
  c.template_store_path = 'public/system/templates'
  c.template_store_type = :<%= @storage %> 
  c.template_types = ["html", "haml"]

  #Note: For basic authentication
  c.authentication = {name: 'feather', password: 'password'}
  #Note: For before filter
  #c.authentication = :authenticate_user!
  
  #c.template_extenstion = 'html'   #default : html
end
