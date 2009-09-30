require File.dirname(__FILE__) + '/spec_helper'

describe Slippers::TemplateGroup do
  it 'should find the right template' do
     subtemplate = Slippers::Engine.new('Hello $first$ $last$')
     template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
     template_group.find(:person).should eql(subtemplate)
     template_group.find('person').should eql(subtemplate)
   end  
   
  it 'should wrap a template string in the engine if it is not one' do
    subtemplate = Slippers::Engine.new('Hello $first$ $last$')
    template_group = Slippers::TemplateGroup.new(:templates => {:person => 'Hello $first$ $last$'})
    template_group.find(:person).should eql(subtemplate)
    template_group.find('person').should eql(subtemplate)
  end
  
  it 'should return nil if it cannot find the right template' do
    template_group = Slippers::TemplateGroup.new()
    template_group.find(:not_this).should eql(nil)
    template_group.find('not_this').should eql(nil)
  end
  
  it 'should look in the super template group if it cannot find the template' do
    template = Slippers::Engine.new('Hello $first$ $last$')
    super_template_group = Slippers::TemplateGroup.new(:templates => {:person => template})
    template_group = Slippers::TemplateGroup.new(:templates => {}, :super_group => super_template_group)
    template_group.find(:person).should eql(template)
    template_group.find(:not_this).should eql(nil)
  end
  
  it 'should render an item if its class is registered' do
    date = Date.new(DateTime.now.year, 2, 4)
    rendered_text = "rendered text"
    template_group = Slippers::TemplateGroup.new(:templates => {Date => OpenStruct.new({:render => rendered_text})})
    
    template_group.has_registered?(date.class).should be_true
    template_group.render(date).should eql(rendered_text)
    
    template_group.has_registered?(template_group.class).should be_false
    template_group.render(template_group).should eql('')
  end
  
  it 'should not render an item if there are no templates' do
    date = Date.new(DateTime.now.year, 2, 4)
    template_group = Slippers::TemplateGroup.new()
    
    template_group.has_registered?(date.class).should be_false
    template_group.render(date).should eql('')
  end
  
  it 'missing handler should be the provided handler' do
    missing_handler = Proc.new{ |foo| foo.to_s }
    template_group = Slippers::TemplateGroup.new(:missing_template_handler => missing_handler)
    template_group.missing_handler.should eql(missing_handler)
  end  
  
  it 'missing handler should be the default handler when none is provided' do
    template_group = Slippers::TemplateGroup.new()
    template_group.missing_handler.should eql(Slippers::Engine::MISSING_HANDLER)
  end  
  
  it 'default string should be the provided default' do
    template_group = Slippers::TemplateGroup.new(:default_string => "Hello Mum")
    template_group.default_string.should eql("Hello Mum")
  end  
  
  it 'missing handler should be the default handler when none is provided' do
    template_group = Slippers::TemplateGroup.new()
    template_group.default_string.should eql(Slippers::Engine::DEFAULT_STRING)
  end  
end