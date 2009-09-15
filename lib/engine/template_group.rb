module Slippers
  class TemplateGroup
    def initialize(params={})
      @templates = params[:templates]
      @super_group = params[:super_group]
    end
    
    def find(subtemplate)
      return nil unless @templates
      return @templates[subtemplate.to_sym] if @templates.include?(subtemplate.to_sym)
      find_in_super_group(subtemplate)
    end
    
    private
      def find_in_super_group(subtemplate)
        return nil unless @super_group 
        @super_group.find(subtemplate)
      end
  end
end