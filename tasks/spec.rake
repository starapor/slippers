require 'spec/rake/spectask'

namespace :spec do
  desc "Run all specs"
  Spec::Rake::SpecTask.new(:run) do |t|
    t.pattern = 'spec/**/*.rb'
  end  
  
  desc "Run all specs with rcov"
  Spec::Rake::SpecTask.new(:run_with_coverage) do |t|
    t.pattern = 'spec/**/*.rb'
    t.rcov = true
  end
end