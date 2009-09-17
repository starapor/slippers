require File.dirname(__FILE__) + '/spec_helper'

class Foo
end
class FooRenderer
  def render(object)
    "foo renderer"
  end
end
describe SlippersParser do
  
  before(:each) do
    @parser = SlippersParser.new
  end
  
  it 'should return an empty string if the subtemplate does not respond to render' do
    template_group = Slippers::TemplateGroup.new(:templates => {:not_a_renderer => stub('renderer')})    
    @parser.parse("$not_a_renderer()$").eval(stub('object'), template_group).should eql('')
  end
    
  it 'should find a renderer based on the type of the object to render' do
    foo = Foo.new
    template_group = Slippers::TemplateGroup.new(:templates => {:foo => FooRenderer.new})    
    @parser.parse("$foo()$").eval(foo, template_group).should eql('foo renderer')
    @parser.parse("$foobar:foo()$").eval({:foobar => foo}, template_group).should eql('foo renderer')
  end    
  
  it 'should find a renderer based on the type of the object to render' do
    foo = Foo.new
    template_group = Slippers::TemplateGroup.new(:templates => {Foo => FooRenderer.new})    
    @parser.parse("$foobar$").eval({:foobar => foo}, template_group).should eql('foo renderer')
  end
end


