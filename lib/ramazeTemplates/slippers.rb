require '/Users/starapor/Development/slippers/slippers'

module Ramaze
  module Template
    class Slippers < Template

      ENGINES[self] = %w[ st ]
      class << self
        def transform(action)
          slippers = wrap_compile(action)
          object_to_render = ::Slippers::BindingWrapper.new(action.binding)
          slippers.render(object_to_render)
        end

        def compile(action, template)
          subtemplates = action.controller.trait[:slippers_options] || {}
         
          template_group_directory = ::Slippers::TemplateGroupDirectory.new(Global.view_root)
          template_group = ::Slippers::TemplateGroup.new(:super_group => template_group_directory, :templates => subtemplates)
          ::Slippers::Engine.new(template, :template_group => template_group)
        end
      end
    end
  end
end
