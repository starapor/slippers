require '/Users/starapor/Development/slippers/template'
require '/Users/starapor/Development/slippers/file_template'
module Ramaze
  module Template
    class Slippers < Template

      ENGINES[self] = %w[ st ]

      class << self
        def transform(action)
          slipper = wrap_compile(action)
          slipper.render(action.binding)
        end

        def compile(action, template)
          subtemplates = action.controller.trait[:slipper_subtemplates] || {}
          subtemplates.merge! :filename => action.template if action.template
          
          template_group = ::Slippers::TemplateGroup.new(Global.view_root)
          ::Slippers.Template.new(template, :template_group => template_group)
      end
    end
  end
end
