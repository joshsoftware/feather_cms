module FeatherCms
  module Model
    module ClassMethods
      def template_content_field(name)
        _cms_content_fields_ << name
      end

      def _cms_content_fields_
        @_cms_content_fields_ ||= []
      end
    end

    module InstanceMethods

      def template_name(field_name)
        "#{self.class.name.downcase}_#{field_name}_#{self.id}.#{Config.template_extenstion}"
      end

      def _template_path(field)
        File.join([Config.template_store_path, template_name(file)])
      end

      def _cms_content(field)
        return nil if self.id.nil?
        TemplateCache.cache_file(template_name(field))
      end

    end
  end
end
