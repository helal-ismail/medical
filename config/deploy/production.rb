server '128.199.230.215', roles: [:web, :app, :db], primary: true
set :stage,           :production
set :branch,        :master
set :rails_env, 'production'
