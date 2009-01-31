require 'renderer'
require 'template_group'
require 'template'
require 'sub_template'
  
describe Renderer, " when rendering a template with no attributes" do
  it "should return the same template" do
    template = Template.new("This is the template.")
    renderer = Renderer.new(template)
    renderer.to_s.should eql("This is the template.")
  end
end

describe Renderer, " when rendering a template with a string as an attribute" do
  it "should substitute in the attribute" do
    template = Template.new("This is the $adjective$ template with $message$.")
    renderer = Renderer.new(template)
    renderer[:message] = "a message"
    renderer[:adjective] = "fantastic"
    renderer.to_s.should eql("This is the fantastic template with a message.")
  end
end


describe Renderer, " when rendering a template without any attributes provided" do
  it "should substitute in an empty string" do
    template = Template.new("This is the $adjective$ template with $message$.")
    renderer = Renderer.new(template)
    renderer.to_s.should eql("This is the  template with .")
  end
end

describe Renderer, " when rendering a template with reference to a subtemplate" do
  it "should render the subtemplate within the template" do
    template = Template.new("This is the $person:person()$ that should be rendered")
    personTemplate = SubTemplate.new("stub object template with $name$")
    
    person = OpenStruct.new
    person.name = "fred"
    renderer = Renderer.new(template, :person => personTemplate)
    renderer[:person] = person
    renderer.to_s.should eql("This is the stub object template with fred that should be rendered")
  end
end

