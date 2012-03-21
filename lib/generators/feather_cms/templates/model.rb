class FeatherPage < ActiveRecord::Base
  include FeatherCms
  template_content_field  :content
end
