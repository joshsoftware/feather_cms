module FeatherCms
  class TemplateCache
    class << self

      def init(options = {})
        @@_cache ||= {}
        @@options = options
      end

      def [](key)
        @@_cache[key.to_s]   
      end

      def []=(k,v)
        @@_cache[k.to_s] = v
      end

      def cache_file(name)
        return self[name] if exist?(name)

        file = _file_path(name)
        self[file] = File.read(file) if File.exist?(file)
      end

      def write_to_file_and_cache(content, file)
        return if cache_file(file) == content
        self[file] = content
        File.open(_file_path(file), 'wb') {|f| f.write(content) }
      end

      def exist?(name)
        @@_cache.key?(name.to_s)
      end

      def clear(name = nil)
        name ? @@_cache.delete(name.to_s) : @@_cache.clear
      end

      def delete_file(name)
        file = _file_path(name) 
        File.delete(file) if File.exist?(file)
        @@_cache.delete(name)
      end

      private 
      def _file_path(name)
        File.join([Config.template_store_path, name])
      end
    end

  end
end
