#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

FsPhilo::Application.load_tasks

# added according to https://github.com/errbit/errbit/issues/179
Rake::Task[:default].clear if Rake::Task.task_defined?(:default)
