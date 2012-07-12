require "bundler/gem_tasks"
require "rspec/core/rake_task"
 
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(-fs --color)
end

task :default => :spec