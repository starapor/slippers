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
  engine :Slippers
  trait :slipper_subtemplates => {:age => Template.new('was born in $year$')}
  def index
    @content = Person.new('Sarah', DateTime.new(1983, 9, 2))
  end
end

Ramaze.start
