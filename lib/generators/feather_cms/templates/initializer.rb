FeatherCms::Config.init do |c|
  c.template_store_path = 'public/system/templates'
  c.template_store_type = :<%= @storage %> 
  #c.template_extenstion = 'html'   #default : html
end
