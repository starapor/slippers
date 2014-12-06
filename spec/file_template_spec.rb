require File.dirname(__FILE__) + '/spec_helper'
  
describe Slippers::FileTemplate, " when rendering" do
  it "should read the template from a file" do
    template_file = Slippers::FileTemplate.new('spec/person_template.st')
    template_file.template.should eql('This is a $template$')
  end
end

