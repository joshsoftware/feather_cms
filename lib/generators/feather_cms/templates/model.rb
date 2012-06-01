class FeatherPage < ActiveRecord::Base
  include FeatherCms

  attr_accessible :status, :layout, :content, :template_type
end
