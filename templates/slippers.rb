module Ramaze
  module Template

    # Is responsible for compiling a template using the SLippers templating engine.
    # Can be found at: http://haml.hamptoncatlin.com/

    class Slippers < Template

      ENGINES[self] = %w[ Slippers ]

      class << self

        # Transform via Slippers templating engine

        def transform action
          slipper = wrap_compile(action)
          slipper.render(action.binding)
        end

        # Instantiates Haml::Engine with the template and haml_options trait from
        # the controller.

        def compile(action, template)
          opts = action.controller.trait[:slippers_options] || {}
          opts.merge! :filename => action.template if action.template

          ::Slippers::Engine::Template.new(template, opts)
        end
      end
    end
  end
end

module Slippers
  module Engine
    class Template
    def render(bindings)
      "Hi: " + bindings#.each_key.inject("Hi: "){|result, element| result + element}            
    end
    def initialize(template, opts)
      @template, @opts = template, opts
    end
  end
  end
end