module FeatherCms
  class Page < ActiveRecord::Base

    STATUS = [:draft, :published]

    attr_accessible :name, :layout, :template_type, :content 

    validates :name, :content, :presence => true
    validates :name, :uniqueness => {:scope => [:status]}
  end
end
