require File.dirname(__FILE__) + '/spec_helper'

describe Slippers::BindingWrapper do
  def f
      @a = 22
      @b = 33
      binding
  end
  
  it "should evaluate the bindings" do
    bindings_wrapper = Slippers::BindingWrapper.new(f())
    bindings_wrapper['a'].should eql(22)
  end
end