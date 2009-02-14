module Slippers
  module AttributeNode 

    def eval(object_to_render, template_group=nil)
      [object_to_render].flatten.inject('') { |rendered, item| rendered + value_of(item).to_s }
    end

    def value_of(item)
      value = item.send(to_s)
      return '' unless value
      value
    end

    def to_s
      text_value
    end

  end

  class TemplateNode < Treetop::Runtime::SyntaxNode


    def eval(object_to_render, template_group)
      apply_attribute_to_subtemplate(object_to_render, template_group)
    end

    def apply_attribute_to_subtemplate(item, template_group)
      return '' unless template_group
      subtemplate = template_group.find(template_path.to_s)
      return '' unless subtemplate
      SlippersParser.new.parse(subtemplate.template).eval(item, template_group)
    end

    def to_s
      text_value
    end

  end

  class ApplyAttributeToTemplateNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group)
      [object_to_render].flatten.inject('') { |rendered, item| rendered + find_attribute_and_render(item, template_group) }
    end

    def find_attribute_and_render(item, template_group)
      object_to_render = attribute.value_of(item)
      [object_to_render].flatten.inject('') { |rendered, i| rendered + template.apply_attribute_to_subtemplate(i, template_group).to_s }
    end


    def to_s
      text_value
    end

  end

  class TemplatedExpressionNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group=nil)
      foo.eval(object_to_render, template_group)
    end

  end

  class ExpressionNode < Treetop::Runtime::SyntaxNode

    def eval(object_to_render, template_group=nil)
      before.eval + templated_expression.eval(object_to_render, template_group) + space.eval + after.eval(object_to_render, template_group)
    end

  end
end