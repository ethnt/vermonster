require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'cane/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--format Fuubar --color --drb)
end

Cane::RakeTask.new(:quality) do |cane|
  cane.style_measure = 140
end

namespace :vcr do
  desc "Delete all of the saves cassettes"
  task :clear do
    exec("rm -rf spec/fixtures/cassettes/*")
  end
end

task :default => :spec
