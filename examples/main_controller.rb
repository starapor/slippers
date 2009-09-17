require 'date'

class Role
  def initialize(name, level)
    @name, @level = name, level
  end
  attr_reader :name, :level
end

class Person
  def initialize(name, date_of_birth, role)
    @name, @dob, @role = name, date_of_birth, role
  end
  attr_reader :name, :dob, :role
end

class RoleRenderer
  def render(role)
    role.level + ' : ' + role.name
  end
end

class AuthorRenderer
  def render(author)
    "the awesome " + author.name
  end
end

class MainController <  Ramaze::Controller
  engine :Slippers
  trait :slippers_options => {:author => AuthorRenderer.new, Role => RoleRenderer.new}

  def index
    @person = Person.new('Sarah', Date.new(1999, 1, 1), Role.new('developer', 'senior'))
    @author = Person.new('Paul', Date.new(1880,3,5), Role.new('author', 'junior'))
    @role = Role.new("sd", "sdffs")
  end
end


