module Slippers
  class TemplateGroupDirectory < TemplateGroup
    def initialize(directory_paths, params={})
      @directory_paths = directory_paths
      @super_group = params[:super_group]
    end
    attr_reader :directory_paths
    
    def find(subtemplate)
      file_name = @directory_paths.map { |directory_path| directory_path + '/' + subtemplate + '.st' }.find { |f| File.exist? f}   
      return Engine.new(FileTemplate.new(file_name).template, :template_group => self) if file_name
      find_renderer_or_supergroup(subtemplate)      
    end
    
    def has_registered?(class_name)
       return false unless @super_group
       @super_group.has_registered?(class_name)  
    end
    
    def render(item)
      return '' unless @super_group
      @super_group.render(item)
    end
    

    def eql?(other)
      return false unless other
      directory_paths.eql?(other.directory_paths)
    end
    def hash
      @directory_paths.hash
    end
    
    private
      def find_renderer_or_supergroup(subtemplate)
        file_name = @directory_paths.map { |directory_path| directory_path + '/' + subtemplate + '.rb' }.find { |f| File.exist? f}   
        return find_in_super_group(subtemplate) unless file_name

        renderer_name = subtemplate.split('/')[-1]
        load File.expand_path(file_name)
        create_renderer renderer_name
      end
      
      def find_in_super_group(subtemplate)
        return nil unless @super_group 
        @super_group.find(subtemplate)
      end
      
      def create_renderer(renderer_name)
        camelCase = renderer_name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
        classes = camelCase.split('::')
        classes.shift if classes.empty? or classes.first.empty?
        const = classes.inject(Object){ |constant, class_name| constant.const_get(class_name) }
        const.new
      end
  end
end