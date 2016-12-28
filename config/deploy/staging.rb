server '45.55.246.135', roles: [:web, :app, :db], primary: true
set :stage,           :staging
set :branch,        :development
set :rails_env, 'staging'
