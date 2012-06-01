class FeatherPage < ActiveRecord::Base
  include FeatherCms

  attr_accessible :status, :layout, :content, :name
  
  validates_format_of :name, :without => /\W/
end
