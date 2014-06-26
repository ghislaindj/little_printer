# SERVERS
role :web, "ghislain.co"
role :app, "ghislain.co"
role :db, "ghislain.co", :primary => true  # This is where Rails migrations will run

# GIT
set :branch,         'master'

set :rvm_ruby_string, 'ruby-2.0.0-p451'
set :rvm_type, :system

set :whenever_command, "bundle exec whenever"
set :whenever_roles, ['app']
require "whenever/capistrano"

require "rvm/capistrano"