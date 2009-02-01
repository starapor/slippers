require '/Users/starapor/Development/slippers/template'
module Ramaze
  module Template
    class Slippers < Template

      ENGINES[self] = %w[ sps ]

      class << self
        def transform(action)
          slipper = wrap_compile(action)
          slipper.render(action.binding)
        end

        def compile(action, template)
          subtemplates = action.controller.trait[:slipper_subtemplates] || {}
          subtemplates.merge! :filename => action.template if action.template

          ::Slippers::Engine::Renderer.new(template, subtemplates)
        end
      end
    end
  end
end

module Slippers
  module Engine
    class Renderer
      def initialize(template, subtemplates)
        @template = Template.new(template, subtemplates)
      end    

      def render(bindings)
        puts eval("@content", bindings)
        @template.to_s(eval("@content", bindings))            
      end
    end
  end
end