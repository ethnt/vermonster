require "bundler/gem_tasks"
require "rspec/core/rake_task"
 
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(-fs --color)
end

task :default => :spec

namespace :vcr do

  desc "Delete all of the saves cassettes."
  task :clear do
    exec("rm -rf spec/fixtures/cassettes/*")
  end
end