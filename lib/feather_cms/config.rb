module FeatherCms
  class Config
    class << self
      attr_accessor :cache_max_limit, :cache_permanent_keys
      attr_accessor :template_store_type

      @@config = {
        :template_store_path => 'templates',
        :use_version => true,
        :template_extenstion => 'html'
      }

      def init(&block)
        yield self if block_given? 

        template_store_type = (template_store_type || :file).to_sym
        FeatherCms::TemplateCache.init
        Dir.mkdir(template_store_path) unless Dir.exists?(template_store_path)

        if defined?(ActionView::Helpers)
          ActionView::Helpers.send(:include, FeatherCms::ViewHelper)
        end

        if defined?(Rails)
          @@config[:layouts] = Dir.entries(Rails.root.to_s + '/app/views/layouts').reject do |i|
            i.start_with?('.', '_', 'feather_layout')
          end.collect{|l| l.split('.').first}
        end
      end

      def template_store_path=(value)
        @@config[:template_store_path] = value
      end

      def template_store_path
        @@config[:template_store_path]
      end

      def template_extenstion=(value)
        @@config[:template_extenstion] = value
      end

      def template_extenstion
        @@config[:template_extenstion] 
      end

      def layouts
        @@config[:layouts]
      end

    end

  end
end
