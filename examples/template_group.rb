require 'examples/helper'
describe Slippers::TemplateGroup do
  it 'should find the right template' do
    subtemplate = Slippers::Template.new('Hello $first$ $last$')
    template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
    template_group.find(:person).should eql(subtemplate)
    template_group.find('person').should eql(subtemplate)
  end
end