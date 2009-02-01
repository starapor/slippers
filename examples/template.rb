require 'template'
require 'ostruct'
  
describe Template, " when rendering a template" do
  it "should return the same template when no substitutions are required" do
    template = Template.new("This is the template with substitutions.")
    template.to_s.should eql("This is the template with substitutions.")
  end
  
  it "should substitute in the attribute when the template has attributes to render" do
    object_to_render = OpenStruct.new({:message => "a message", :adjective => "fantastic"})
    template = Template.new("This is the $adjective$ template with $message$.")
    template.to_s(object_to_render).should eql("This is the fantastic template with a message.")
  end
  
  it "should substitute in an empty string when the attribute cannot be found" do
    template = Template.new("This is the $adjective$ template with $message$.")
    template.to_s(OpenStruct.new).should eql("This is the  template with .")
  end
  
  it "should render the subtemplate that is refererenced within the template" do
    person = OpenStruct.new({:name => OpenStruct.new({:first => 'fred', :last => 'flinstone'})})
    person_template = Template.new("template to render $first$ $last$")
    template = Template.new("This is the $name:person$!", :person => person_template)    
    template.to_s(person).should eql("This is the template to render fred flinstone!")
  end
  
  it "should render a list of objects" do
    people = [OpenStruct.new({:name => 'fred'}), OpenStruct.new({:name => 'barney'})]
    template = Template.new("template to render $name$ ")
    template.to_s(people).should eql("template to render fred template to render barney ")
  end
  
end

