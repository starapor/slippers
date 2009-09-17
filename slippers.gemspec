# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{slippers}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sarah Taraporewalla"]
  s.date = %q{2009-09-17}
  s.description = %q{A strict templating library for ruby}
  s.email = %q{me@sarahtaraporewalla.com}
  s.files = ["LICENSE", "Rakefile", "README", "VERSION.yml", "lib/engine", "lib/engine/binding_wrapper.rb", "lib/engine/engine.rb", "lib/engine/file_template.rb", "lib/engine/slippers.treetop", "lib/engine/slippers_nodes.rb", "lib/engine/template.rb", "lib/engine/template_group.rb", "lib/engine/template_group_directory.rb", "lib/ramazeTemplates", "lib/ramazeTemplates/0001-Adding-slippers-as-a-new-template.patch", "lib/ramazeTemplates/0002-Fixing-problem-with-using-other-renderers.patch", "lib/ramazeTemplates/slippers.rb", "lib/slippers.rb", "spec/binding_wrapper.rb", "spec/engine.rb", "spec/file_template.rb", "spec/parser.rb", "spec/person_template.st", "spec/slippers_spec.rb", "spec/spec_helper.rb", "spec/template_group.rb", "spec/template_group_directory.rb", "spec/views", "spec/views/index.st", "spec/views/money.rb", "spec/views/person", "spec/views/person/age.st", "spec/views/person/date_renderer.rb", "spec/views/person/name.st", "examples/blog", "examples/blog/blog.db", "examples/blog/controller", "examples/blog/controller/main.rb", "examples/blog/model", "examples/blog/model/entry.rb", "examples/blog/public", "examples/blog/public/styles", "examples/blog/public/styles/blog.css", "examples/blog/README", "examples/blog/spec", "examples/blog/spec/blog.rb", "examples/blog/start.rb", "examples/blog/view", "examples/blog/view/edit.st", "examples/blog/view/edit.xhtml", "examples/blog/view/entry.st", "examples/blog/view/index.st", "examples/blog/view/index.xhtml", "examples/blog/view/layout.st", "examples/blog/view/layout.xhtml", "examples/blog/view/new.st", "examples/blog/view/new.xhtml", "examples/forms", "examples/forms/controller", "examples/forms/controller/init.rb", "examples/forms/controller/main.rb", "examples/forms/controller/registration.rb", "examples/forms/forms.db", "examples/forms/model", "examples/forms/model/core_extensions", "examples/forms/model/core_extensions/string_extensions.rb", "examples/forms/model/field.rb", "examples/forms/model/form.rb", "examples/forms/model/init.rb", "examples/forms/model/orm", "examples/forms/model/orm/registration.rb", "examples/forms/model/registration_form_builder.rb", "examples/forms/model/registration_repository.rb", "examples/forms/model/registration_rules", "examples/forms/model/registration_rules/incorrect_email_format.rb", "examples/forms/model/registration_rules/number_field.rb", "examples/forms/model/registration_rules/required_field.rb", "examples/forms/model/registration_validator.rb", "examples/forms/public", "examples/forms/public/css", "examples/forms/public/css/ramaze_error.css", "examples/forms/public/dispatch.fcgi", "examples/forms/public/favicon.ico", "examples/forms/public/js", "examples/forms/public/js/jquery.js", "examples/forms/public/ramaze.png", "examples/forms/public/web-application.js", "examples/forms/Rakefile", "examples/forms/spec", "examples/forms/spec/form_spec.rb", "examples/forms/spec/main.rb", "examples/forms/spec/registration_controller_spec.rb", "examples/forms/spec/registration_repository_spec.rb", "examples/forms/spec/registration_validator_spec.rb", "examples/forms/spec/spec_helper.rb", "examples/forms/start.rb", "examples/forms/start.ru", "examples/forms/view", "examples/forms/view/error.xhtml", "examples/forms/view/index.xhtml", "examples/forms/view/page.xhtml", "examples/forms/view/registration", "examples/forms/view/registration/index.st", "examples/main_controller.rb", "examples/start.rb", "examples/todolist", "examples/todolist/controller", "examples/todolist/controller/main.rb", "examples/todolist/layout", "examples/todolist/layout/page.rb", "examples/todolist/model", "examples/todolist/model/tasks.rb", "examples/todolist/public", "examples/todolist/public/favicon.ico", "examples/todolist/public/js", "examples/todolist/public/js/jquery.js", "examples/todolist/public/ramaze.png", "examples/todolist/README", "examples/todolist/start.rb", "examples/todolist/todolist.db", "examples/todolist/view", "examples/todolist/view/index.st", "examples/todolist/view/index.xhtml", "examples/todolist/view/new.st", "examples/todolist/view/new.xhtml", "examples/todolist/view/tasks.st", "examples/todolist.db", "examples/view", "examples/view/index.st", "examples/view/person", "examples/view/person/age.st", "examples/view/person/age_renderer.rb", "examples/view/person/index.st"]
  s.homepage = %q{http://github.com/starapor/slippers}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A strict templating library for Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<schacon-git>, [">= 0"])
      s.add_runtime_dependency(%q<treetop>, [">= 0"])
    else
      s.add_dependency(%q<schacon-git>, [">= 0"])
      s.add_dependency(%q<treetop>, [">= 0"])
    end
  else
    s.add_dependency(%q<schacon-git>, [">= 0"])
    s.add_dependency(%q<treetop>, [">= 0"])
  end
end
