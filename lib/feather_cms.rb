require "feather_cms/version"
require "feather_cms/template_cache"
require "feather_cms/config"
require "feather_cms/model"
require "feather_cms/railtie" if defined?(Rails)

module FeatherCms
  include Model

  def self.included(base)
    base.extend FeatherCms::Model::ClassMethods
    base.template_content_field :content
    base.send(:include, FeatherCms::Model::InstanceMethods)
  end
end
