module FeatherCms
  module Model
    module ClassMethods
      def template_content_field(name)
        _cms_content_fields_ << name
        return unless Config.template_store_type == :file 

        attr_accessor name.to_sym

        class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{name}
            @#{name} || _cms_content(:#{name})
          end
        METHOD

        class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{name}_changed?
            @#{name} != _cms_content(:#{name}) 
          end
        METHOD
      end

      def _cms_content_fields_
        @_cms_content_fields_ ||= []
      end

      def define_feather_cms_callbacks
        after_destroy { |template| 
          self.class._cms_content_fields_.each do |f|
            TemplateCache.delete_file(_template_path(f))
          end
        }

        after_save { |template|
          self.class._cms_content_fields_.each do  |f|
            TemplateCache.write_to_file_and_cache(send(f), template_name(f))
          end
        }
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
