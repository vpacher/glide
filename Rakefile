require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
	t.rspec_opts = "--color --format doc"
end

task :test => :spec
task :default => :spec