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

        template_store_type = :db
        FeatherCms::TemplateCache.init
        Dir.mkdir(template_store_path) unless Dir.exists?(template_store_path)

        if defined?(Rails)
          @@config[:layouts] = Dir.entries(Rails.root.to_s + '/app/views/layouts').reject do |i|
            i.start_with?('.', '_', 'feather_layout')
          end.collect{|l| l.split('.').first}
        end
      end

      def layouts
        @@config[:layouts]
      end

      [:template_store_path, :template_extenstion, :authentication].each do |attr|
        class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{attr}=(value)
            @@config[:#{attr}] = value
          end

          def #{attr}
            @@config[:#{attr}]
          end
        METHOD
      end

    end

  end
end
