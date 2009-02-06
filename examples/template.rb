require 'template'
require 'file_template'

  
describe Slippers::Template, " when rendering" do
  it "should read the template from a file" do
    template_file = Slippers::FileTemplate.new('examples/person_template.template')
    template_file.template.should eql('This is a $template$')
  end
end

