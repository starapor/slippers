module Slippers 
  class Template
    def initialize(template)
      @template = template
    end
    attr_reader :template
    
    def eql?(other)
      template.eql?(other.template)
    end
    
    def hash
      template.hash
    end
    
  end    
end