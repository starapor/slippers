# Getting started

```bash
gem install slippers
```

```ruby
require 'slippers'
template = "This is a string without any holes in it"
engine = Slippers::Engine.new(template)
engine.render #=> "This is a string without any holes in it"
```

# Philosophy

There are many template engines that you can choose for the generation of views in your mvc application. The problem with most of the them, however, is that they are too permissive. These turing-complete engines allow for many complex constructs within the template, which begin at simple if statements and for loops, and expand to complex object traversal. While these permissive languages are intended to offer great flexibility, in reality they promote bad practices. Allowing logic to permeate your view is bad for many reasons: firstly, the code in views is rarely tested; secondly, the separation between the models and the view blurs and business logic creeps into the view.

All we want our template engine to do is read a string which has holes in it, and replace those holes with the desired string, much like mail merge. String Template is a template engine originally for Java but now ported to C# and python, which enforces strict separation of model and view by only supporting these strings with holes. Unfortunately, it has not been ported to ruby...until now.

Introducing...Slippers, a strict template engine for ruby. Slippers supports the syntax from string template including anonymous templates, named templates and template group directories but also goes beyond this to allow you to use your own renderers.

# Examples

## Rendering template of a string without any holes

```ruby
template = "This is a string without any holes in it"
engine = Slippers::Engine.new(template)
engine.render
```
    #=> "This is a string without any holes in it"

## Filling in a hole within a template

```ruby
template = "This is a string with a message of $message$"
engine = Slippers::Engine.new(template)
engine.render(:message => "hello world")
```

    #=> "This is a string with a message of hello world"

## Rendering a subtemplate within a template

```ruby
subtemplate = Slippers::Template.new("this is a subtemplate")
template_group = Slippers::TemplateGroup.new(:templates => {:message => subtemplate})
template = "This is a template and then $message()$"
engine = Slippers::Engine.new(template, :template_group => template_group)
engine.render
```

    #=> "This is a template and then this is a subtemplate"

## Applying an object to a subtemplate

```ruby
subtemplate = Slippers::Template.new("this is a subtemplate with a message of $saying$")
template_group = Slippers::TemplateGroup.new(:templates => {:message_subtemplate => subtemplate})
template = "This is a template and then $message:message_subtemplate()$!"
engine = Slippers::Engine.new(template, :template_group => template_group)
engine.render(:message => {:saying => 'hello world'})
```
    #=> "This is a template and then this is a subtemplate with a message of hello world!"

## Applying an object to an anonymous subtemplate

```ruby
template = "This is a template and then $message:{this is a subtemplate with a message of $saying$}$!"
engine = Slippers::Engine.new(template)
engine.render(:message => {:saying => 'hello world'})
```
    #=> "This is a template and then this is a subtemplate with a message of hello world!"

## Render a subtemplate using a different rendering technology

```ruby
age_renderer = AgeRenderer.new
subtemplate = Slippers::Engine.new('$first$ $last$')
person = OpenStruct.new({:name => {:first => 'Fred', :last => 'Flinstone'}, :dob => Date.new(DateTime.now.year - 34, 2, 4)})
template_group = Slippers::TemplateGroup.new(:templates => {:name => subtemplate, :age => age_renderer})
engine = Slippers::Engine.new("Introducing $name:name()$ who is $dob:age()$.", :template_group => template_group)
engine.render(person)
```
    #=> "Introducing Fred Flinstone who is 34 years old."

## Select a renderer based on the type of the object to render

```ruby
person = OpenStruct.new({:name => {:first => 'Fred', :last => 'Flinstone'}, :dob => Date.new(DateTime.now.year-34, 2, 4)})
template_group = Slippers::TemplateGroup.new(:templates => {:name => Slippers::Engine.new('$first$ $last$'), Date => AgeRenderer.new})
engine = Slippers::Engine.new("Introducing $name:name()$ who is $dob$.", :template_group => template_group)
engine.render(person)
```
    #=> "Introducing Fred Flinstone who is 34 years old."

## Use the specified expression options to render list items

```ruby
template = 'This is a list of values $values; null="-1", seperator=", "$'
engine = Slippers::Engine.new(template)
engine.render(:values => [1,2,3,nil])
```
    #=> "This is a list of values 1, 2, 3, -1"


