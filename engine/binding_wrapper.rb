module Slippers
  class BindingWrapper
    def initialize(bindings)
      @bindings = bindings
    end
    def method_missing(method, *args)
      eval('@'+ method.to_s, @bindings) || super
    end
  end
end
