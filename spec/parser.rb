require 'spec/helper'

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
    @parser.parse('this should be !@£%^&*()').eval.should eql('this should be !@£%^&*()')
  end
  
  it 'should find the keyword within the delimiters' do
    message = OpenStruct.new({:message => 'the message', :name => 'fred'})
    @parser.parse('$message$').eval(message).should eql('the message')
    @parser.parse('$message$ for $name$').eval(message).should eql('the message for fred')
    @parser.parse('we want to find $message$').eval(message).should eql('we want to find the message')
    @parser.parse('$message$ has spoken').eval(message).should eql('the message has spoken')
    @parser.parse('Yes! $message$ has spoken').eval(message).should eql('Yes! the message has spoken')
  end
  
  it 'should parse the subtemplate found within the delimiters' do
    template = Slippers::Template.new('template for this')
    template_group = Slippers::TemplateGroup.new(:templates => {:template => template})
    @parser.parse('$template()$').eval(nil, template_group).should eql('template for this')
    @parser.parse('Stuff before $template()$ and after').eval(nil, template_group).should eql('Stuff before template for this and after')
  end 
  
  it 'should apply the attribute to a subtemplate when parsing it' do
    subtemplate = Slippers::Template.new('Hello $first$ $last$')
    template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
    person = OpenStruct.new({:name => OpenStruct.new({:first => 'fred', :last => 'flinstone'})})
    @parser.parse('$name:person()$').eval(person, template_group).should eql('Hello fred flinstone')
  end
  
  it 'should not match on escaped delimiters' do
    #@parser.parse('stuff \$notmatched\$').eval.should eql('stuff \$notmatched\$')
  end
  
  it "should render a list of objects" do
    people = [OpenStruct.new({:name => 'fred'}), OpenStruct.new({:name => 'barney'})]
    @parser.parse('this is $name$').eval(people).should eql("this is fredbarney")
  end
  
  it "should substitue in an empty string when the subtemplate cannot be found" do
    person = OpenStruct.new({:name => 'red'})
    @parser.parse("This is the unknown template $name:unknown()$!").eval(person).should eql("This is the unknown template !")
  end
  
  it "should substitute in an empty string when the attribute cannot be found" do  
    @parser.parse("This is the $adjective$ template with $message$.").eval(OpenStruct.new).should eql("This is the  template with .")
  end
  
  it "should give the subtemplates the parameters provided" do
    name_template = Slippers::Template.new('$first$ $last$')
    #@parser.parse("This is the template to render $name(:first => 'fred', :last => 'flinstone')$").eval(:object, :name => name_template).should eql("This is the template to render fred flinstone")
  end
  
  it "should parse the file template from the template group" do
    template_group = Slippers::TemplateGroupDirectory.new('view')
    name = OpenStruct.new({:first => 'fred', :last => 'flinestone'})
    people = OpenStruct.new({:fred => name})
    @parser.parse("should parse $person/name()$").eval(name, template_group).should eql("should parse fred flinestone")
    @parser.parse("should parse $fred:person/name()$").eval(people, template_group).should eql("should parse fred flinestone")
  end
  
  it "should convert attribute to string" do
    fred = OpenStruct.new({:name => 'fred', :dob => DateTime.new(1983, 1, 2)})
    template_group = Slippers::TemplateGroup.new(:templates => {:date => Slippers::Template.new('$year$')} )
    @parser.parse("This is $name$ who was born in $dob:date()$").eval(fred, template_group).should eql('This is fred who was born in 1983')
  end
   
end


