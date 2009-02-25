require 'rake'
require 'spec/rake/spectask'

desc "Run all examples"
Spec::Rake::SpecTask.new('examples') do |t|
  t.spec_files = FileList['engine/spec/**/*.rb']
end

desc "Generate HTML report for failing examples"
Spec::Rake::SpecTask.new('failing_examples_with_html') do |t|
  t.spec_files = FileList['failing_examples/**/*.rb']
  t.spec_opts = ["--format", "html:doc/reports/tools/failing_examples.html", "--diff"]
  t.fail_on_error = false
end

desc "Generate the gem using technicalpickles jeweler"
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "slippers"
    gem.summary = "A strict templating library for Ruby"
    gem.email = "me@sarahtaraporewalla.com"
    gem.homepage = "http://github.com/starapor/slippers"
    gem.description = "A strict templating library for ruby"
    gem.authors = ["Sarah Taraporewalla"]
    gem.files =  FileList["[A-Z]*", "{engine,examples,ramazeTemplates,view}/**/*"]
    gem.add_dependency 'schacon-git'
  end
rescue LoadError
  puts "Slippers, or one of its dependencies, is not available. Install it with: sudo gem install starapor-slippers -s http://gems.github.com"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'slippers'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.libs << 'lib' << 'spec'
  t.spec_files = FileList['spec/**/*.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |t|
  t.libs << 'lib' << 'spec'
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  puts "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
end

task :default => :spec
