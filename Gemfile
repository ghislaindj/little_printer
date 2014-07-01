source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.5'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "mongoid", git: "https://github.com/mongoid/mongoid.git"
gem "devise", git: "git@github.com:plataformatec/devise.git"
gem "rails_config"

gem "compass-rails", git: "https://github.com/Compass/compass-rails.git"
gem 'colored'
gem 'bootstrap-sass', '~> 3.1.0'
gem 'bootstrap-sass-extras'


# Backoffice
gem "chartkick"

# gem "mongoid-paperclip", :require => "mongoid_paperclip"
# gem "paperclip"

gem "whenever"
gem "httparty"
gem "typhoeus"

group :production, :staging do
  gem "unicorn"
  gem "execjs"
  gem "therubyracer"
end

group :development do
  gem 'rails_layout'
  gem "capistrano"
  gem "rvm-capistrano"
  gem "debugger"
  gem "awesome_print"
  gem "thin"
  gem "net-ssh"
  gem "github_api"
  gem "foreman"
end