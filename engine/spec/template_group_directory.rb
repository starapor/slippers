require 'engine/spec/helper'
require 'tempfile'
require 'active_support'

describe Slippers::TemplateGroupDirectory do
  
  it 'should find the file in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new('engine/spec/views')
    template_group.find('index').should eql(Slippers::Engine.new('Hey foo', :template_group => template_group))
    template_group.find('person/age').should eql(Slippers::Engine.new('The age for him is $age$', :template_group => template_group))
  end

  it 'should return nil if it cannot find the file in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new('engine/spec/views')
    template_group.find('person/not_found').should eql(nil)
  end

  it 'should read the st template file and return a new slipers engine for it' do
    template_group = Slippers::TemplateGroupDirectory.new('engine/spec/views')
    template_group.find('index').should eql(Slippers::Engine.new('Hey foo', :template_group => template_group))
    template_group.find('person/age').should eql(Slippers::Engine.new('The age for him is $age$', :template_group => template_group))
  end
  
  it 'should load the ruby file found in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new('engine/spec/views')
    template_group.find('person/date_renderer').class.should eql(DateRenderer)
    template_group.find('money').class.should eql(Money)
  end
  
  it 'should look in the super template group if it cannot find the template' do
    template = stub 'template'
    super_template_group = Slippers::TemplateGroup.new(:templates => {:person => template})
    template_group = Slippers::TemplateGroupDirectory.new('engine/spec/views', :super_group => super_template_group)
    template_group.find('person').should eql(template)
    template_group.find('not_this').should eql(nil)
  end
  
  

end