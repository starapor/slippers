require '/Users/starapor/Development/slippers/template_group_directory'
require '/Users/starapor/Development/slippers/engine'

module Ramaze
  module Template
    class Slippers < Template

      ENGINES[self] = %w[ st ]
      class << self
        def transform(action)
          slippers = wrap_compile(action)
           object_to_render = eval("@content", action.binding)
          slippers.render(object_to_render)
        end

        def compile(action, template)
          subtemplates = action.controller.trait[:slipper_subtemplates] || {}
          subtemplates.merge! :filename => action.template if action.template
         
          
          template_group = ::Slippers::TemplateGroupDirectory.new(Global.view_root)
          ::Slippers::Engine.new(template, :template_group => template_group)
        end
      end
    end
  end
end
