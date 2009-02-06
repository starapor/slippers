require 'rubygems'
require 'treetop'
require 'slippers'
require 'template'

module Slippers
  class Engine
    
    def initialize(template, params)
      @main_template = Slippers::Template.new(template)
      @template_group = params[:template_group]
    end
    
    def render(bindings)
      object_to_render = eval("@content", bindings)
      parser = TemplateParser.new.parse(object_to_render)
      parser.parse(@main_template.template).eval(object_to_render, @template_group) 
    end
    
    def read(template, subtemplates, view_root)
        puts Dir[view_root + '/**']
      file_templates = {}
      Dir[view_root + '/*/**'].each do |filename|
         
        if File.file?(view_root + '/' + filename)
          template_key = File::basename(filename, '.sps').gsub('/', '_').to_sym
          file_templates[template_key] = Slippers::FileTemplate.new(filename)
        end
      end
                
      subtemplates.merge! file_templates.each { |key, subtemplate| subtemplate.add_subtemplates(file_templates)}

      @template = Slippers::Template.new(template, subtemplates)
    end    


  end
end