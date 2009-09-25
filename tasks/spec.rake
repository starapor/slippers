require 'spec/rake/spectask'

namespace :spec do
  desc "Run all specs"
  Spec::Rake::SpecTask.new(:run) do |t|
    t.pattern = 'spec/**/*.rb'
    t.rcov = true
  end
end