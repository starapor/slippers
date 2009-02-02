require '/Users/starapor/Development/slippers/template'
require '/Users/starapor/Development/slippers/file_template'
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

          ::Slippers::Engine::Renderer.new(template, subtemplates, Global.view_root)
        end
        
      end
    end
  end
end

module Slippers
  module Engine
    class Renderer
      def initialize(template, subtemplates, view_root)
          puts Dir[view_root + '/**']
        file_templates = {}
        Dir[view_root + '/*/**'].each do |filename|
           
          if File.file?(view_root + '/' + filename)
            template_key = File::basename(filename, '.sps').gsub('/', '_').to_sym
            file_templates[template_key] = Slippers::FileTemplate.new(filename)
          end
        end
                  
        subtemplates.merge! file_templates.each { |key, subtemplate| subtemplate.add_subtemplates(file_templates)}

        @template = Slippers::Template.new(template, subtemplates)
      end    

      def render(bindings)
        @template.to_s(eval("@content", bindings))            
      end
    end
  end
end