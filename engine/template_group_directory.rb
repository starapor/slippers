require 'engine/template_group'
require 'engine/file_template'
module Slippers
  class TemplateGroupDirectory < TemplateGroup
    def initialize(directory_path)
      @directory_path = directory_path
    end
    def find(subtemplate)
      file_name = @directory_path + '/' + subtemplate + '.st'
      #return unless File.exist? file_name
      FileTemplate.new(file_name)
    end
  end
end