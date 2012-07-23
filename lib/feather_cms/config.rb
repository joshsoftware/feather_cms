module FeatherCms
  class Config
    class << self

      def init(&block)
        @@config ||= {}

        yield self if block_given? 

        @@config[:layouts] = Dir.entries(Rails.root.to_s + '/app/views/layouts').reject do |i|
          i.start_with?('.', '_') || File.directory?(i)
        end.collect{|l| l.split('.').first}
      end

      def layouts
        @@config[:layouts]
      end

      [:authentication, :sign_out_url, :template_types].each do |attr|
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
