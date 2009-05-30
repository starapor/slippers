module Slippers
  class BindingWrapper
    def initialize(bindings)
      @bindings = bindings
    end
    def [](method)
      eval('@'+ method.to_s, @bindings)
    end
  end
end
