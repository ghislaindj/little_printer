# SERVERS
role :web, "ghislain.co"
role :app, "ghislain.co"            
role :db, "ghislain.co", :primary => true  # This is where Rails migrations will run

# GIT
set :branch,         'master'

set :rvm_ruby_string, 'ruby-2.0.0-p247'
set :rvm_type, :user

before 'deploy:setup', 'rvm:install_rvm'  # install/update RVM
before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset (both if missing)

require "rvm/capistrano"