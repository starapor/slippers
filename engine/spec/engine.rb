require 'engine/spec/helper'
describe Slippers::Engine do
  before do
    template = 'Hello $first$ $last$'
    @engine = Slippers::Engine.new(template)
  end
  
  it "Rendering template of a string without any holes" do
    template = "This is a string without any holes in it"
    engine = Slippers::Engine.new(template)
    engine.render(nil).should eql("This is a string without any holes in it")
  end

  it "Filling in a hole within a template" do
    template = "This is a string with a message of $message$"
    engine = Slippers::Engine.new(template)
    engine.render(:message => "hello world").should eql("This is a string with a message of hello world")
  end

  it "Rendering a subtemplate within a template" do
    subtemplate = Slippers::Template.new("this is a subtemplate")
    template_group = Slippers::TemplateGroup.new(:templates => {:message => subtemplate})
    template = "This is a template and then $message()$"
    engine = Slippers::Engine.new(template, :template_group => template_group)
    engine.render(nil).should eql("This is a template and then this is a subtemplate")
  end

  it "Applying a new object to a subtemplate" do
    subtemplate = Slippers::Template.new("this is a subtemplate with a message of $saying$")
    template_group = Slippers::TemplateGroup.new(:templates => {:message_subtemplate => subtemplate})
    template = "This is a template and then $message:message_subtemplate()$!"
    engine = Slippers::Engine.new(template, :template_group => template_group)
    engine.render(:message => {:saying => 'hello world'}).should eql("This is a template and then this is a subtemplate with a message of hello world!")
  end
  
    
  it "should render the object within the template" do
    person = OpenStruct.new({:first => 'fred', :last => 'flinstone'})
    @engine.render(person).should eql('Hello fred flinstone')
  end
  
  it 'should render a bindings wrapper' do
    @first = 'fred'
    @last = 'flinstone'
    
    person_binding = Slippers::BindingWrapper.new(binding)
    @engine.render(person_binding).should eql('Hello fred flinstone')
  end
  
  it 'should render an array' do
    subtemplate = Slippers::Template.new('Hello $first$ $last$ ')
    template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
    template = 'Say: $people:person()$'
    @people = [OpenStruct.new({:first => 'fred', :last => 'flinstone'}), OpenStruct.new({:first => 'barney', :last => 'rubble'})]
    
    engine = Slippers::Engine.new(template, :template_group => template_group)
    engine.render(Slippers::BindingWrapper.new(binding)).should eql('Say: Hello fred flinstone Hello barney rubble ')
  end

  
  
end