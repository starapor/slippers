# coding:utf-8
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
  
  it "should render the default string when the attribute cannot be found on the object to render and there is no template group" do  
    Slippers::Engine::DEFAULT_STRING.should eql('') 
    @parser.parse("This is the $adjective$ template with $message$.").eval(OpenStruct.new).should eql("This is the  template with .")
    @parser.parse("$not_me$").eval(stub()).should eql('')
  end  
  
  it "should render the default string of the template group when the attribute cannot be found on the object to render" do  
    template_group = Slippers::TemplateGroup.new(:default_string => "foo" )
    template_group.default_string.should eql('foo')
    @parser.parse("$not_me$").eval(stub(), template_group).should eql('foo')
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
  
  it 'should use the specified expression options to render list items' do
    @parser.parse('$list; null="-1", seperator=", "$').eval(:list => [1,2,nil,3]).should eql("1, 2, -1, 3")
    @parser.parse('$list; seperator=", "$').eval(:list => [1,2,3]).should eql("1, 2, 3")
    @parser.parse('$list; seperator="!!"$').eval(:list => [1,2,3,nil]).should eql("1!!2!!3")
    @parser.parse('$list; null="-1"$').eval(:list => [1,nil,3]).should eql("1-13")
  end
  
  it 'should conditionally parse some text' do
    @parser.parse("$if(greeting)$ Hello $end$").eval(:greeting => true).should eql(" Hello ")
    @parser.parse("$if(greeting)$ Hello $end$").eval(:greeting => true).should eql(" Hello ")
    @parser.parse("$if(greeting)$ Hello $end$").eval(:greeting => false).should eql("")
    @parser.parse("$if(greeting)$ Hello $end$").eval(:greeting => nil).should eql("")
    @parser.parse("$if(greeting)$Hello$else$Goodbye$end$").eval(:greeting => true).should eql("Hello")
    @parser.parse("$if(greeting)$ Hello $else$ Goodbye $end$").eval(:greeting => false).should eql(" Goodbye ")
    @parser.parse("$if(greeting)$ Hello $end$").eval(:greetingzzzz => true).should eql("")
    @parser.parse("$if(greeting)$ $greeting$ $end$").eval(:greeting => 'Hi').should eql(" Hi ")
  end

  it 'should conditionally parse a template' do
    @parser.parse("$if(greeting)$ $greeting$ $end$").eval(:greeting => 'Hi').should eql(" Hi ")
    @parser.parse("$if(greeting)$$greeting$ $else$ Nothing to see here $end$").eval(:greeting => 'Hi').should eql("Hi ")
    @parser.parse("$if(greeting)$$greeting$ $else$ Nothing to see here $end$").eval(:greeting => nil).should eql(" Nothing to see here ")
  end

end


