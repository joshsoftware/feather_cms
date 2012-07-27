FeatherCms::Config.init do |c|
  #Note: For basic authentication
  c.authentication = {name: 'feather', password: 'password'}
  #Note: For before filter
  #c.authentication = :authenticate_user!
end
