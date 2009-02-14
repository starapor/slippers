require 'engine/spec/helper'
describe Slippers::Engine do
  before do
    template = 'Hello $first$ $last$'
    @engine = Slippers::Engine.new(template)
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