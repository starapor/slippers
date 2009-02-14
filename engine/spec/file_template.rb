require 'engine/spec/helper'
  
describe Slippers::FileTemplate, " when rendering" do
  it "should read the template from a file" do
    template_file = Slippers::FileTemplate.new('engine/spec/person_template.template')
    template_file.template.should eql('This is a $template$')
  end
end

