require 'engine/engine'

module Slippers
  class TemplateGroupDirectory < TemplateGroup
    def initialize(directory_path)
      @directory_path = directory_path
    end
    attr_reader :directory_path
    
    def find(subtemplate)

      file_name = @directory_path + '/' + subtemplate + '.st'
      return find_renderer(subtemplate) unless File.exist?(file_name)
      Engine.new(FileTemplate.new(file_name).template, :template_group => self)
      
    end
    
    def find_renderer(subtemplate)
      file_name = @directory_path + '/' + subtemplate + '.rb'
      return nil unless File.exist?(file_name)
      renderer_name = subtemplate.split('/')[-1]
      autoload(renderer_name.camelize.to_sym, file_name)
      renderer_name.camelize.constantize.new
    end
    
    
    def eql?(other)
      return false unless other
      directory_path.eql?(other.directory_path)
    end
    def hash
      @directory_path.hash
    end
  end
end