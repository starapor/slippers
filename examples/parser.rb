require 'rubygems'
require 'treetop'
require 'slippers'
require 'ostruct'

describe SlippersParser do
  it "should return the string unparsed when there are no keywords in it" do
    SlippersParser.new.parse('this should be returned unchanged').eval(nil).should eql('this should be returned unchanged')
  end
  
  it 'should find the keyword within the delimiters' do
    message = OpenStruct.new({:message => 'the message'})
    SlippersParser.new.parse('$message$').eval(message).should eql('the message')
    SlippersParser.new.parse('We want to find $message$').eval(message).should eql('We want to find the message')
  end  
end
