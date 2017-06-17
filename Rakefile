# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

task :default => %i[style tests]

task :style => ['style:server']
task :tests => ['spec:server']

namespace :spec do
  task :server => [:spec]
end

namespace :style do
  task :server do
    sh 'rubocop'
  end
end

Rails.application.load_tasks
