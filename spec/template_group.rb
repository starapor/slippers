require File.dirname(__FILE__) + '/spec_helper'

describe Slippers::TemplateGroup do
  it 'should find the right template' do
    subtemplate = Slippers::Engine.new('Hello $first$ $last$')
    template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
    template_group.find(:person).should eql(subtemplate)
    template_group.find('person').should eql(subtemplate)
  end
  
  it 'should return nil if it cannot find the right template' do
    template_group = Slippers::TemplateGroup.new()
    template_group.find(:not_this).should eql(nil)
    template_group.find('not_this').should eql(nil)
  end
  
  it 'should look in the super template group if it cannot find the template' do
    template = stub 'template'
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

end