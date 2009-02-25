Gem::Specification.new do |s|
  s.name = %q{slippers}
  s.version = "0.0.0"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sarah Taraporewalla"]
  s.date = %q{2009-02-25}
  s.description = %q{A strict templating library for ruby}
  s.email = %q{me@sarahtaraporewalla.com}
  s.files = ["LICENSE", "Rakefile", "README", "VERSION.yml", "lib/engine", "lib/engine/binding_wrapper.rb", "lib/engine/engine.rb", "lib/engine/file_template.rb", "lib/engine/slippers.treetop", "lib/engine/slippers_nodes.rb", "lib/engine/template.rb", "lib/engine/template_group.rb", "lib/engine/template_group_directory.rb", "lib/ramazeTemplates", "lib/ramazeTemplates/0001-SarahTaraporewalla-adding-new-template-file-for-sli.patch", "lib/ramazeTemplates/slippers.rb", "lib/slippers.rb", "spec/binding_wrapper.rb", "spec/engine.rb", "spec/file_template.rb", "spec/parser.rb", "spec/person_template.st", "spec/slippers_spec.rb", "spec/spec_helper.rb", "spec/template_group.rb", "spec/template_group_directory.rb", "spec/views", "spec/views/index.st", "spec/views/money.rb", "spec/views/person", "spec/views/person/age.st", "spec/views/person/date_renderer.rb", "spec/views/person/name.st", "examples/blog", "examples/blog/blog.db", "examples/blog/controller", "examples/blog/controller/main.rb", "examples/blog/model", "examples/blog/model/entry.rb", "examples/blog/public", "examples/blog/public/styles", "examples/blog/public/styles/blog.css", "examples/blog/README", "examples/blog/spec", "examples/blog/spec/blog.rb", "examples/blog/start.rb", "examples/blog/view", "examples/blog/view/edit.st", "examples/blog/view/edit.xhtml", "examples/blog/view/entry.st", "examples/blog/view/index.st", "examples/blog/view/index.xhtml", "examples/blog/view/layout.st", "examples/blog/view/layout.xhtml", "examples/blog/view/new.st", "examples/blog/view/new.xhtml", "examples/main_controller.rb", "examples/start.rb", "examples/todolist", "examples/todolist/public", "examples/todolist/public/favicon.ico", "examples/todolist/public/js", "examples/todolist/public/js/jquery.js", "examples/todolist/public/ramaze.png", "examples/todolist/Rakefile", "examples/todolist/README", "examples/todolist/spec", "examples/todolist/spec/todolist.rb", "examples/todolist/src", "examples/todolist/src/controller", "examples/todolist/src/controller/main.rb", "examples/todolist/src/element", "examples/todolist/src/element/page.rb", "examples/todolist/src/model.rb", "examples/todolist/start.rb", "examples/todolist/template", "examples/todolist/template/index.st", "examples/todolist/template/index.xhtml", "examples/todolist/template/new.st", "examples/todolist/template/new.xhtml", "examples/todolist/template/tasks.st", "examples/todolist/todolist.db", "examples/todolist.db", "examples/view", "examples/view/index.st", "examples/view/person", "examples/view/person/age.st", "examples/view/person/index.st", "examples/view/person/name.st"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/starapor/slippers}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.0.1}
  s.summary = %q{A strict templating library for Ruby}

  s.add_dependency(%q<schacon-git>, [">= 0"])
end
