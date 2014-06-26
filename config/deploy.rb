load "deploy/assets"
default_run_options[:pty] = true

set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

# APPLICATION
set :application, "daily_mood"
set :user,        "#{application}"
set :use_sudo,    false
set :deploy_to,   "/home/#{application}/www"
set :deploy_via,  :remote_cache
set :keep_releases, 5

# GIT
set :repository,     "git@github.com:ghislaindj/#{application}.git"
set :scm,            :git
set :scm_username,   "git"

# BUNDLER
require "bundler/capistrano"

#set :default_env, 'production'
set(:rails_env) { "#{stage}" }

# Bonus! Colors are pretty!
def red(str)
  "\e[31m#{str}\e[0m"
end

# ASSETS
before 'deploy:assets:precompile' do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

after 'deploy:setup' do
  run "mkdir #{shared_path}/config"
  run "touch #{shared_path}/config/database.yml"
  # touch "#{shared_path}/config/mongoid.yml"
end

namespace :deploy do
  desc "Reload the database with seed data"
  task :seed, :roles => :db do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake db:seed"
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; RAILS_ENV=#{rails_env} bundle exec unicorn_rails -c config/unicorn/#{rails_env}.rb -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`"
  end  
end

namespace :rails do
  desc "Remote console"
  task :console, :roles => :app do
    run_interactively "RAILS_ENV=#{rails_env} bundle exec rails c"
  end

  desc "Remote logs"
  task :log, :roles => :app do
    run_interactively "tail -f log/#{rails_env}.log"
  end
end

def run_interactively(command, server=nil)
  server ||= find_servers_for_task(current_task).first
  exec %Q(ssh -t #{user}@#{server.host} "/bin/bash --login -c 'cd #{current_path} && rvm use #{rvm_ruby_string} && #{command}'")
end
