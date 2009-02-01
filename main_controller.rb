require 'rubygems'
require 'ramaze'
require 'template'

class Person
  def initialize(name, date_of_birth)
    @name, @dob = name, date_of_birth
  end
  attr_reader :name, :dob
end

class MainController <  Ramaze::Controller
  def index
    sarah = Person.new('Sarah', DateTime.new(1983, 9, 2))
    sub_templates = {:age => Template.new('was born in $year$')}
    renderer = Template.new "Introducing $name$ who $dob:age$", sub_templates
    renderer.to_s(sarah)
  end
end

Ramaze.start