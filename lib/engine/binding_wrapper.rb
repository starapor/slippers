module Slippers
  class BindingWrapper
    def initialize(bindings)
      @bindings = bindings
    end
    def [](method)
      eval('@'+ method.to_s, @bindings)
    end
    
    def to_s
      "BindingWrapper with #{@bindings}"
    end
  end
end
