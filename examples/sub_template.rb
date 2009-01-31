require 'sub_template'
require 'ostruct'

describe SubTemplate, " when rendering a subtemplate with no attributes" do
  it "should return the same subtemplate" do
    template = SubTemplate.new("This is the template.")
    template.replace_with(:object, {}).should eql("This is the template.")
  end
end 

describe SubTemplate, " when rendering a subtemplate with a string as an attribute" do
  it "should substitute in the attribute" do
    template = SubTemplate.new("This is the $attribute$ template with $message$.")
    object = OpenStruct.new
    object.attribute = "fantastic"
    object.message = "a message"
    template.replace_with(object, {}).should eql("This is the fantastic template with a message.")
  end
end