require File.dirname(__FILE__) + '/../model/form'
require File.dirname(__FILE__) + '/../model/field'

describe Form do
  it 'should update the value of a field on the form' do
    form = Form.new(:blah => "")
    form.update(:blah => "foo")
    form[:blah].should eql("foo")
  end
  
  it 'should find the value of a field in the form' do
    form = Form.new(:blah => "foo")
    form[:blah].should eql("foo")
  end
  
end