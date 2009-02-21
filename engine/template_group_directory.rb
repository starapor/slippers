require 'engine/template_group'
require 'engine/file_template'
module Slippers
  class TemplateGroupDirectory < TemplateGroup
    def initialize(directory_path)
      @directory_path = directory_path
    end
    attr_reader :directory_path
    def find(subtemplate)
      file_name = @directory_path + '/' + subtemplate + '.st'
      Engine.new(FileTemplate.new(file_name).template, :template_group => self)
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