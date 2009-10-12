module Slippers
  module AttributeToRenderNode

    def eval(object_to_render, template_group)
      [object_to_render].flatten.inject('') { |rendered, item| rendered + render(value_of(item, template_group), template_group) }
    end

    def value_of(item, template_group)
      return default_string(template_group) if attribute == ''
      return item.to_s if attribute == 'it'
      return item[to_sym] if item.respond_to?('[]'.to_sym) && item[to_sym]
      return item.send(attribute) if item.respond_to?(attribute)
      default_string(template_group)
    end

    def render(object_to_render, template_group)
      substitue_null_values(object_to_render)
      return template_group.render(object_to_render) if template_group && template_group.has_registered?(object_to_render.class)
      return object_to_render.compact.join(seperator) if object_to_render.respond_to?('join')
      object_to_render.to_s
    end
    
    def substitue_null_values(object_to_render)
      return unless null_values && object_to_render.respond_to?('map!')
      object_to_render.map!{|x| if x then x else null_values end }
    end
    
    def to_sym
      attribute.to_sym
    end
    
    def null_values
    end
    
    def seperator
    end
    
    def attribute
      text_value
    end
    
    private
      def default_string(template_group)
        return Slippers::Engine::DEFAULT_STRING unless template_group
        template_group.default_string
      end
  end
  
  class AttributeWithExpressionOptionNode < Treetop::Runtime::SyntaxNode
    include AttributeToRenderNode
    def seperator
      seperator_value.seps.to_s if seperator_value.elements
    end
    def null_values
      null_subtitute.nulls.to_s if null_subtitute.elements
    end
  end
  
  class TemplateNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group)
      apply_attribute_to_subtemplate(object_to_render, template_group)
    end

    def apply_attribute_to_subtemplate(item, template_group)
      return invoke_misisng_handler unless template_group
      subtemplate = template_group.find(template_path.to_s)
      return invoke_misisng_handler(template_group.missing_handler) unless (subtemplate && subtemplate.respond_to?('render')) 
      subtemplate.render(item)
    end
    
    private
      def invoke_misisng_handler(missing_handler=Slippers::Engine::MISSING_HANDLER)
        return missing_handler.call(template_path.to_s) if missing_handler.arity == 1
        missing_handler.call
      end
  end
  
  class AnonymousTemplateNode < Treetop::Runtime::SyntaxNode
    
    def eval(object_to_render, template_group)
      apply_attribute_to_subtemplate(object_to_render, template_group)
    end
    
    def apply_attribute_to_subtemplate(item, template_group)
      SlippersParser.new.parse(anonymous_template_words.to_s).eval(item, template_group)
    end
  end

  class ApplyAttributeToTemplateNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group)
      [object_to_render].flatten.inject('') { |rendered, item| rendered + find_attribute_and_render(item, template_group) }
    end

    def find_attribute_and_render(item, template_group)
      object_to_render = attribute.value_of(item, template_group)
      [object_to_render].flatten.inject('') { |rendered, i| rendered + template.apply_attribute_to_subtemplate(i, template_group).to_s }
    end
  end
  
  class ConditionalTemplateNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group)
      attribute = if_clause.value_of(object_to_render, template_group)
      if (attribute && attribute != default_string(template_group)) then
        if_expression.eval(object_to_render, template_group)
      else
        if else_clause.elements then else_clause.else_expression.eval(object_to_render, template_group) else default_string(template_group) end
      end
    end

    private
      def default_string(template_group)
        return Slippers::Engine::DEFAULT_STRING unless template_group
        template_group.default_string
      end
  end

  class TemplatedExpressionNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group)
      foo.eval(object_to_render, template_group)
    end

  end

  class ExpressionNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group=nil)
      before.eval(object_to_render, template_group) + expression_to_render.eval(object_to_render, template_group) + space.eval + after.eval(object_to_render, template_group)
    end

  end
end