module Slippers
  class TemplateGroup
    def initialize(params={})
      @templates = params[:templates]
      @super_group = params[:super_group]
    end
    
    def find(subtemplate)
      return nil unless @templates
      return create_template(subtemplate.to_sym) if @templates.include?(subtemplate.to_sym)
      find_in_super_group(subtemplate)
    end
    
    def has_registered?(class_name)
       return false unless @templates
       return true if @templates.include?(class_name) 
       return false unless @super_group
       @super_group.has_registered?(class_name)  
    end
    
    def render(item)
      return '' unless @templates
      return @templates[item.class].render(item) if has_registered?(item.class)
      return '' unless @super_group
      @super_group.render(item)
    end
    
    private
      def find_in_super_group(subtemplate)
        return nil unless @super_group 
        @super_group.find(subtemplate)
      end
      
      def create_template(subtemplate)
        template = @templates[subtemplate]
        return template unless template.is_a?(String)
        Slippers::Engine.new(template)
      end
  end
end