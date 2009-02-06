module Slippers
  class TemplateGroup
    def initialize(params)
      @templates = params[:templates]
    end
    
    def find(subtemplate)
      @templates[subtemplate.to_sym]
    end
  end
end