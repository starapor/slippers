require 'engine/spec/helper'
require 'tempfile'

describe Slippers::TemplateGroupDirectory do
  it 'should find the file template in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new('engine/spec/views')
    template_group.find('index').should eql(Slippers::Engine.new('Hey foo', :template_group => template_group))
    template_group.find('person/age').should eql(Slippers::Engine.new('The age for him is $age$', :template_group => template_group))
  end

end