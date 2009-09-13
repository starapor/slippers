require 'slippers'

module Ramaze
  module View
    module Slippers
      def self.call(action, string)
        slippers = View.compile(string){|s| ::Slippers::Engine.new(s, :template_group => template_group(action)) }
        object_to_render = ::Slippers::BindingWrapper.new(action.instance.binding)
        html = slippers.render(object_to_render)
        return html, 'text/html'
      end
      
      private
        def self.template_group(action)
          subtemplates = action.instance.ancestral_trait[:slippers_options] || {}
          view_root = "#{action.instance.options[:roots]}/#{action.instance.options[:views]}"
          template_group_directory = ::Slippers::TemplateGroupDirectory.new(view_root)
          template_group = ::Slippers::TemplateGroup.new(:super_group => template_group_directory, :templates => subtemplates)
        end
    end
  end
end
