require File.dirname(__FILE__) + '/spec_helper'

describe Slippers::Engine do
  before do
    template = 'Hello $first$ $last$'
    @engine = Slippers::Engine.new(template)
  end
  
  it "should render a template without any holes" do
    template = "This is a string without any holes in it"
    engine = Slippers::Engine.new(template)
    engine.render.should eql("This is a string without any holes in it")
  end

  it "should fill in a hole within a template" do
    template = "This is a string with a message of $message$"
    engine = Slippers::Engine.new(template)
    engine.render(:message => "hello world").should eql("This is a string with a message of hello world")
  end

  it "should render a subtemplate within a template" do
    subtemplate = Slippers::Engine.new("this is a subtemplate")
    template_group = Slippers::TemplateGroup.new(:templates => {:message => subtemplate})
    template = "This is a template and then $message()$"
    engine = Slippers::Engine.new(template, :template_group => template_group)
    engine.render.should eql("This is a template and then this is a subtemplate")
  end

  it "should apply a template to an attribute" do
    subtemplate = Slippers::Engine.new("this is a subtemplate with a message of $saying$")
    template_group = Slippers::TemplateGroup.new(:templates => {:message_subtemplate => subtemplate})
    template = "This is a template and then $message:message_subtemplate()$!"
    engine = Slippers::Engine.new(template, :template_group => template_group)
    engine.render(:message => {:saying => 'hello world'}).should eql("This is a template and then this is a subtemplate with a message of hello world!")
  end

  it "should apply an anonymous subtemplate to an attribute" do
    template = "This is a template and then $message:{this is a subtemplate with a message of $saying$}$!"
    engine = Slippers::Engine.new(template)
    engine.render(:message => {:saying => 'hello world'}).should eql("This is a template and then this is a subtemplate with a message of hello world!")
  end
  
  it "should render a subtemplate using different rendering technologies" do
    age_renderer = AgeRenderer.new
    subtemplate = Slippers::Engine.new('$first$ $last$')
    person = OpenStruct.new({:name => {:last => 'Flinstone', :first => 'Fred'}, :dob => Date.new(DateTime.now.year - 34, 2, 4)})
    template_group = Slippers::TemplateGroup.new(:templates => {:name => subtemplate, :age => age_renderer})
    engine = Slippers::Engine.new("Introducing $name:name()$ who is $dob:age()$.", :template_group => template_group)
    engine.render(person).should eql("Introducing Fred Flinstone who is 34 years old.")
  end
  
  it "should select a renderer based on the type of the object to render" do
    person = OpenStruct.new({:name => {:first => 'Fred', :last => 'Flinstone'}, :dob => Date.new(DateTime.now.year - 34, 2, 4)})
    template_group = Slippers::TemplateGroup.new(:templates => {:name => Slippers::Engine.new('$first$ $last$'), Date => AgeRenderer.new})
    
    engine = Slippers::Engine.new("Introducing $name:name()$ who is $dob$.", :template_group => template_group)
    engine.render(person).should eql("Introducing Fred Flinstone who is 34 years old.")
  end
   
  it 'should render a bindings wrapper' do
    @first = 'fred'
    @last = 'flinstone'
    
    person_binding = Slippers::BindingWrapper.new(binding)
    @engine.render(person_binding).should eql('Hello fred flinstone')
  end
  
  it 'should render a list of objects' do
    subtemplate = Slippers::Engine.new('Hello $first$ $last$ ')
    template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
    template = 'Say: $people:person()$'
    @people = [OpenStruct.new({:first => 'fred', :last => 'flinstone'}), OpenStruct.new({:first => 'barney', :last => 'rubble'})]
    
    engine = Slippers::Engine.new(template, :template_group => template_group)
    engine.render(Slippers::BindingWrapper.new(binding)).should eql('Say: Hello fred flinstone Hello barney rubble ')
  end
  
  it 'should render empty string if the template can not be evaluated' do
    engine = Slippers::Engine.new('$this_is_bad')
    engine.render(stub('object')).should eql('')
  end
end

class AgeRenderer  
  def render(date)
     age = DateTime.now.year - date.year
     age.to_s + " years old"
  end
end