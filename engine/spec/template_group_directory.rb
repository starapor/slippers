require 'engine/spec/helper'

describe Slippers::TemplateGroupDirectory do
  it 'should find the file template in the directory folder' do
    template_group = Slippers::TemplateGroupDirectory.new('view')
    template_group.find('index').filename.should eql('view/index.st')
    template_group.find('person/age').filename.should eql('view/person/age.st')
  end

end