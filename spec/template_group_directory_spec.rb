require File.dirname(__FILE__) + '/spec_helper'

describe Slippers::TemplateGroupDirectory do
  
  it 'should find the file in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'])
    template_group.find('index').should eql(Slippers::Engine.new('Hey foo', :template_group => template_group))
    template_group.find('person/age').should eql(Slippers::Engine.new('The age for him is $age$', :template_group => template_group))
  end

  it 'should return nil if it cannot find the file in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'])
    template_group.find('person/not_found').should eql(nil)
  end

  it 'should read the st template file and return a new slipers engine for it' do
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'])
    template_group.find('index').should eql(Slippers::Engine.new('Hey foo', :template_group => template_group))
    template_group.find('person/age').should eql(Slippers::Engine.new('The age for him is $age$', :template_group => template_group))
  end
  
  it 'should load the ruby file found in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'])
    template_group.find('person/date_renderer').class.should eql(DateRenderer)
    template_group.find('money').class.should eql(Money)
  end
  
  it 'should look in the super template group if it cannot find the template' do
    template = double 'template'
    super_template_group = Slippers::TemplateGroup.new(:templates => {:person => template})
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'], :super_group => super_template_group)
    template_group.find('person').should eql(template)
    template_group.find('not_this').should eql(nil)
  end
  
  it 'should look in all the directories provided for the template' do
    template_group = Slippers::TemplateGroupDirectory.new(['examples/blog', 'spec/views'])
    template_group.find('index').should eql(Slippers::Engine.new('Hey foo', :template_group => template_group))
    template_group.find('person/age').should eql(Slippers::Engine.new('The age for him is $age$', :template_group => template_group))
  end
  
  it 'should accept missing handlers' do 
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'], :missing_template_handler => nil, :default_string => nil)
    template_group.find('index').should eql(Slippers::Engine.new('Hey foo', :template_group => template_group))
    template_group.find('person/age').should eql(Slippers::Engine.new('The age for him is $age$', :template_group => template_group))   
  end
  
  it 'missing handler should be the provided handler' do
    missing_handler = Proc.new{ |foo| foo.to_s }
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'], :missing_template_handler => missing_handler)
    template_group.missing_handler.should eql(missing_handler)
  end  
  
  it 'missing handler should be the default handler when none is provided' do
    template_group = template_group = Slippers::TemplateGroupDirectory.new(['spec/views'])
    template_group.missing_handler.should eql(Slippers::Engine::MISSING_HANDLER)
  end  
  
  it 'default string should be the provided default' do
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'], :default_string => "Hello Mum")
    template_group.default_string.should eql("Hello Mum")
  end  
  
  it 'missing handler should be the default handler when none is provided' do
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'])
    template_group.default_string.should eql(Slippers::Engine::DEFAULT_STRING)
  end  
  

end
