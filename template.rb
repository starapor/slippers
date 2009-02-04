require 'ostruct'
module Slippers 
  class Template
    def initialize(template, subtemplates={})
      @template = template
      @subtemplates = subtemplates
    end
    attr_reader :template, :subtemplates
  
    def to_s(object_to_render=nil)
      objects_as_list = [object_to_render].flatten
      objects_as_list.inject('') {|rendered, item| rendered + substitute_objects(item) }
    end
  
    def substitute_objects(object_to_render)
      attributes_replaced = template.gsub(/\$([\w]+)\$/) { |s| render object_to_render.send($1) }
      templates_replaced = attributes_replaced.gsub(/\$([\w]+)\(\)\$/) {|s| render object_to_render, $1}
      templates_with_parameters_replaced = templates_replaced.gsub(/\$([\w]+)\(([:\w]+\s*=>\s*\'?[\w]+\'?)\)\$/) {|s| render new_object($2), $1}
      templates_for_next_level_replaced = templates_with_parameters_replaced.gsub(/\$([\w]+):?([\w]*)\(\)\$/) {|s| render object_to_render.send($1), $2}
    end
  
    def render(attribute, template=nil)
      return attribute if !template or template.empty?
      return '' unless @subtemplates[template.to_sym]
      @subtemplates[template.to_sym].to_s(attribute)
    end
    
    def add_subtemplates(subtemplates)
      @subtemplates = subtemplates
    end
    
    def new_object(parameters)
      OpenStruct.new(parameters)
    end
  end    
end