require File.dirname(__FILE__) + '/spec_helper'

describe SlippersParser do
  
  before(:each) do
    @parser = SlippersParser.new
  end
  
  it "should return the string unparsed when there are no keywords in it" do
    @parser.parse('').eval(nil).should eql('')
    @parser.parse('  ').eval(nil).should eql('  ')
    @parser.parse('this should be returned unchanged').eval.should eql('this should be returned unchanged')
    @parser.parse(' this should be returned unchanged ').eval.should eql(' this should be returned unchanged ')
    @parser.parse('this should be 1234567890 ').eval.should eql('this should be 1234567890 ')
    @parser.parse('this should be abc1234567890 ').eval.should eql('this should be abc1234567890 ')
    @parser.parse('this should be !@¬£%^&*()').eval.should eql('this should be !@¬£%^&*()')
  end
  
  it 'should find the keyword within the delimiters' do
    message = OpenStruct.new({:message => 'the message', :message2 => 'the second message', :name => 'fred', :full_name => 'fred flinstone'})
    @parser.parse('$message$').eval(message).should eql('the message')
    @parser.parse('$message$ for $name$').eval(message).should eql('the message for fred')
    @parser.parse('we want to find $message$').eval(message).should eql('we want to find the message')
    @parser.parse('$message$ has spoken').eval(message).should eql('the message has spoken')
    @parser.parse('Yes! $message$ has spoken').eval(message).should eql('Yes! the message has spoken')
    @parser.parse('Yes! $full_name$ has spoken').eval(message).should eql('Yes! fred flinstone has spoken')
    @parser.parse('Yes! $message2$ has spoken').eval(message).should eql('Yes! the second message has spoken')
    @parser.parse('Yes! "$message2$" has spoken').eval(message).should eql('Yes! "the second message" has spoken')
    @parser.parse('$$').eval(message).should eql('')
  end
  
  it 'should not match on escaped delimiters' do
    @parser.parse('stuff \$notmatched\$').eval(stub(:nothing)).should eql('stuff \$notmatched\$')
  end
  
  it "should render a list of objects" do
    people = [OpenStruct.new({:name => 'fred'}), OpenStruct.new({:name => 'barney'}) ]
    @parser.parse('this is $name$').eval(people).should eql("this is fredbarney")
  end
  
  it "should substitute in an empty string when the attribute cannot be found" do  
    @parser.parse("This is the $adjective$ template with $message$.").eval(OpenStruct.new).should eql("This is the  template with .")
  end
  
  it "should convert attribute to string" do
    fred = OpenStruct.new({:name => 'fred', :dob => DateTime.new(1983, 1, 2)})
    template_group = Slippers::TemplateGroup.new(:templates => {:date => Slippers::Engine.new('$year$')} )
    @parser.parse("This is $name$ who was born in $dob:date()$").eval(fred, template_group).should eql('This is fred who was born in 1983')
  end

  it "should render a hash" do
    hash_object = {:title => 'Domain driven design', :author => 'Eric Evans', :find => 'method on a hash'}
    @parser.parse("should parse $title$ by $author$").eval(hash_object).should eql("should parse Domain driven design by Eric Evans")
    @parser.parse("should parse a symbol before a $find$").eval(hash_object).should eql('should parse a symbol before a method on a hash')
  end

  it "should render a symbol on a hash before its methods" do
    hash_object = {:find => 'method on a hash'}
    @parser.parse("should parse a symbol before a $find$").eval(hash_object).should eql('should parse a symbol before a method on a hash')
    @parser.parse("should still render the method $size$").eval(hash_object).should eql('should still render the method 1')
  end
  
  it 'should return an empty string if the template is not correctly formed' do
    @parser.parse("$not_properly_formed").should eql(nil)
  end
  
  it 'should render an empty string if it cannot find the attribute to render' do
    @parser.parse("$not_me$").eval(:object).should eql('')
  end
  
   
end


