Treetop.load File.dirname(__FILE__) + '/slippers'

module Slippers
  class Engine
    DEFAULT_STRING = ''
    def initialize(template, params={})
      @main_template = Slippers::Template.new(template)
      @template_group = params[:template_group]
    end
    attr_reader :main_template, :template_group
    
    def render(object_to_render=nil)
      parser = SlippersParser.new
      parse_tree = parser.parse(@main_template.template)
      return '' unless parse_tree
      parse_tree.eval(object_to_render, @template_group) 
    end
    
    def eql?(other)
      @main_template.eql?(other.main_template) && @template_group.eql?(other.template_group)
    end
    
    def hash
      @main_template.hash + @template_group.hash*23
    end

  end
end