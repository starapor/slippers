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
    @parser.parse('').eval(nil).should eql('')
    #@parser.parse(' ').eval(nil).should eql(' ')
    @parser.parse('this should be returned unchanged').eval(nil).should eql('this should be returned unchanged')
    @parser.parse(' this should be returned unchanged ').eval(nil).should eql(' this should be returned unchanged ')
    @parser.parse('this should be 1234567890 ').eval(nil).should eql('this should be 1234567890 ')
    @parser.parse('this should be abc1234567890 ').eval(nil).should eql('this should be abc1234567890 ')
    #@parser.parse('this should be @£$%^&*() ').eval(nil).should eql(' this should be!@£$%^&*()')
  end
  
  it 'should find the keyword within the delimiters' do
    message = OpenStruct.new({:message => 'the message', :name => 'fred'})
    @parser.parse('$message$').eval(message).should eql('the message')
    @parser.parse('$message$ for $name$').eval(message).should eql('the message for fred')
    @parser.parse('We want to find $message$').eval(message).should eql('We want to find the message')
    @parser.parse('$message$ has spoken').eval(message).should eql('the message has spoken')
    @parser.parse('Yes $message$ has spoken').eval(message).should eql('Yes the message has spoken')
  end
  
  it 'should parse the subtemplate found within the delimiters' do
    template = Slippers::Template.new('template for this')
    @parser.parse('$template()$').eval(nil, {:template => template}).should eql('template for this')
    @parser.parse('Stuff before $template()$ and after').eval(nil, {:template => template}).should eql('Stuff before template for this and after')
  end 
  
  it 'should apply the attribute to a subtemplate when parsing it' do
    template = Slippers::Template.new('Hello $first$ $last$')
    person = OpenStruct.new({:name => OpenStruct.new({:first => 'fred', :last => 'flinstone'})})
    @parser.parse('$name:template()$').eval(person, {:template => template}).should eql('Hello fred flinstone')
  end 
end


