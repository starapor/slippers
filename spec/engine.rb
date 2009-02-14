require 'spec/helper'
describe Slippers::Engine do
  before do
    template = 'Hello $first$ $last$'
    @engine = Slippers::Engine.new(template)
  end
    
  it "should render the template" do
    person = OpenStruct.new({:first => 'fred', :last => 'flinstone'})
    @engine.render(person).should eql('Hello fred flinstone')
  end
  
end