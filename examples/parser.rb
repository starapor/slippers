require 'rubygems'
require 'treetop'
require 'slippers'
require 'ostruct'
require 'template'


describe SlippersParser do
  
  before(:each) do
    @parser = SlippersParser.new
  end
  
  it "should return the string unparsed when there are no keywords in it" do
    @parser.parse('this should be returned unchanged').eval(nil).should eql('this should be returned unchanged')
  end
  
  it 'should find the keyword within the delimiters' do
    message = OpenStruct.new({:message => 'the message'})
    @parser.parse('$message$').eval(message).should eql('the message')
    @parser.parse('We want to find $message$').eval(message).should eql('We want to find the message')
  end
  
  it 'should return the template found within the delimiters' do
    template = Slippers::Template.new('template for this')
    @parser.parse('$template()$').eval(nil, {:template => template}).should eql('template for this')
  end 
end
