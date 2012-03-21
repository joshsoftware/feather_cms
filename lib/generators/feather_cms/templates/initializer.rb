FeatherCms::Config.init do |c|
  c.template_store_path = 'public/system/templates'
  c.template_store_type = :<%= @storage %> 
  #c.cache_max_limit = 50           #default : 20
  #c.template_extenstion = 'html'   #default : html
end
