require 'template'
require 'file_template'
require 'ostruct'
  
describe Slippers::Template, " when rendering" do
  it "should return the same template when no substitutions are required" do
    template = Slippers::Template.new("This is the template with substitutions.")
    template.to_s.should eql("This is the template with substitutions.")
  end
  
  it "should substitute in the attribute when the template has attributes to render" do
    object_to_render = OpenStruct.new({:message => "a message", :adjective => "fantastic"})
    template = Slippers::Template.new("This is the $adjective$ template with $message$.")
    template.to_s(object_to_render).should eql("This is the fantastic template with a message.")
  end
  
  it "should substitute in an empty string when the attribute cannot be found" do
    template = Slippers::Template.new("This is the $adjective$ template with $message$.")
    template.to_s(OpenStruct.new).should eql("This is the  template with .")
  end
  
  it "should render a subtemplate that is referenced within the template" do 
    name = OpenStruct.new({:first => 'fred', :last => 'flinshone'})
    name_template = Slippers::Template.new('$first$ $last$')
    template = Slippers::Template.new('This is the template to render $name()$', :name => name_template)
    template.to_s(name).should eql("This is the template to render fred flinshone")
  end  

  it "should render the attribute for a subtemplate that is refererenced within the template" do
    person = OpenStruct.new({:name => OpenStruct.new({:first => 'fred', :last => 'flinstone'})})
    person_template = Slippers::Template.new("template to render $first$ $last$")
    template = Slippers::Template.new("This is the $name:person()$!", :person => person_template)    
    template.to_s(person).should eql("This is the template to render fred flinstone!")
  end

  it "should render a list of objects" do
    people = [OpenStruct.new({:name => 'fred'}), OpenStruct.new({:name => 'barney'})]
    template = Slippers::Template.new("template to render $name$ ")
    template.to_s(people).should eql("template to render fred template to render barney ")
  end
  
  it "should read the template from a file" do
    template = Slippers::FileTemplate.new('examples/person_template.template')
    template.to_s(OpenStruct.new({:template => 'Hello'})).should eql('This is a Hello')
  end
  
  it "should add new subtemplates" do 
    person = OpenStruct.new({:name => OpenStruct.new({:first => 'fred', :last => 'flinstone'})})
    person_template = Slippers::Template.new("template to render $first$ $last$")
    template = Slippers::Template.new("This is the $name:person()$!")
    template.add_subtemplates(:person => person_template)    
    template.to_s(person).should eql("This is the template to render fred flinstone!")
  end
  
  it "should substitue in an empty string when the subtemplate cannot be found" do
    person = OpenStruct.new({:name => OpenStruct.new({:first => 'fred', :last => 'flinstone'})})
    template = Slippers::Template.new("This is the unknown template $name:unknown()$!")    
    template.to_s(person).should eql("This is the unknown template !")
  end
end

