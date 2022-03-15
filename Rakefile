# encoding: UTF-8
require "bundler/gem_tasks"
require 'rspec/core/rake_task'


begin
  RSpec::Core::RakeTask.new(:spec)

  desc 'Rake test'
  task default: :test
rescue LoadError
	fail
end

desc 'Pre-commit hook (test)'
task pre_commit: :test

desc 'Run spec tests'
task test: :spec
