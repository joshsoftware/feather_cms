module FeatherCms
  class TemplateCache
    class << self

      def init(options = {})
        @@_cache_map ||= {}
        @@options = options
        @@options[:max_limit] ||= 20
        @@_callbacks = {:before => [], :after => []}

        unless @@options[:permanent_keys].is_a?(Array)
          @@options[:permanent_keys] = [@@options[:permanent_keys]]
        end
        @@options[:permanent_keys] = @@options[:permanent_keys].compact

        self
      end

      def [](key)
        @@_cache_map[key.to_s]   
      end

      def []=(k,v)
        clear_all if @@_cache_map.length == @@options[:max_limit]

        @@_cache_map[k.to_s] = _call_callbacks(:before, k, v)
        _call_callbacks(:after, k, v)
      end

      def cache_file(name, file = nil)
        return self[name] unless file
        self[name] = File.read(file) if File.exist?(file)
      end

      def get_or_cache_file(file)
        self[file] || cache_file(file, _file_path(file)) 
      end

      def write_to_file_and_cache(content, file)
        return if get_or_cache_file(file) == content
        self[file] = content
        File.open(_file_path(file), 'wb') {|f| f.write(content) }
      end

      def exist?(name)
        @@_cache_map.key?(name.to_s)
      end

      def clear_all
        @@_cache_map.delete_if{|k,v| !@@options[:permanent_keys].include?(k)}
      end

      def clear(name)
        @@_cache_map.delete(name.to_s)
      end

      def delete_file(name)
        file = _file_path(name) 
        File.delete(file) if File.exist?(file)
        @@_cache_map.delete(name)
      end

      def before_add(options = {}, &block)
        _register_callback(:before, options, &block)
      end

      def after_add(options = {}, &block)
        _register_callback(:after, options, &block)
      end

      def view_callbacks
        @@_callbacks.inspect
      end

      private 
      def _file_path(name)
        File.join([Config.template_store_path, name])
      end

      def _register_callback(type, options, &block)
        @@_callbacks[type] << [@@_callbacks[type].length + 1, options, block] 
      end

      def _call_callbacks(type, key, value)
        @@_callbacks[type].each do |callback|
          value = callback.last.call(key, value)
        end
        value
      end

    end

  end
end
