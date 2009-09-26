require File.dirname(__FILE__) + '/spec_helper'

class Person
  def initialize(first, last)
    @first, @last = first, last
  end
  attr_reader :first, :last
  
end

describe SlippersParser do
  
  before(:each) do
    @parser = SlippersParser.new
  end

  it 'should parse the subtemplate found within the delimiters' do
    template = Slippers::Engine.new('template for this')
    template_with_underscore = Slippers::Engine.new('template with underscore')
    predefined_templates = {:template => template, :template_with_underscore => template_with_underscore, :template2 => template}
    template_group = Slippers::TemplateGroup.new(:templates => predefined_templates)
    
    @parser.parse('$template()$').eval(nil, template_group).should eql('template for this')
    @parser.parse('$template2()$').eval(nil, template_group).should eql('template for this')
    @parser.parse('Stuff before $template()$ and after').eval(nil, template_group).should eql('Stuff before template for this and after')
    @parser.parse('then there is $template_with_underscore()$').eval(nil, template_group).should eql('then there is template with underscore')
  end 

   it 'should apply the attribute to a subtemplate when parsing it' do
     person = OpenStruct.new({:name => Person.new('fred', 'flinstone')})
     subtemplate = Slippers::Engine.new('Hello $first$ $last$')
     template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
     
     @parser.parse('$name:person()$').eval(person, template_group).should eql('Hello fred flinstone')
   end
  
  it 'should parse an anonymous subtemplate' do
    @parser.parse('$people:{template for this $name$}$').eval(:people => {:name => 'fred'}).should eql('template for this fred')
    @parser.parse('$people:{template for this "$name$"}$').eval(:people => {:name => 'fred'}).should eql('template for this "fred"')
    @parser.parse('${template for this $name$}$').eval(:name => 'fred').should eql('template for this fred')
  end
  
  it "should apply a list of objects to subtemplates" do
    people = [ Person.new('fred', 'flinstone'), Person.new('barney', 'rubble') ]
    subtemplate = Slippers::Engine.new('this is $first$ $last$ ')
    template_group = Slippers::TemplateGroup.new(:templates => {:person => subtemplate})
    object_to_render = OpenStruct.new({:people => people})

    @parser.parse('$people:person()$').eval(object_to_render, template_group).should eql("this is fred flinstone this is barney rubble ")
  end

  it "should render an empty string when the subtemplate cannot be found" do
    @parser.parse("This is the unknown template $unknown()$!").eval(Person.new('fred', 'flinstone')).should eql("This is the unknown template !")
    @parser.parse("This is the unknown template $first:unknown()$!").eval(Person.new('fred', 'flinstone')).should eql("This is the unknown template !")
  end
  
  it "should parse the file template from the template group" do
    template_group = Slippers::TemplateGroupDirectory.new(['spec/views'])
    name = OpenStruct.new({:first => 'fred', :last => 'flinestone'})
    people = OpenStruct.new({:fred => name})
    @parser.parse("should parse $person/name()$").eval(name, template_group).should eql("should parse fred flinestone")
    @parser.parse("should parse $fred:person/name()$").eval(people, template_group).should eql("should parse fred flinestone")
  end

  
end


