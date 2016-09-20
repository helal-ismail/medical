Rails.application.routes.draw do
  apipie
  root 'touch#touch'
  
  namespace :api do
    post 'user' , to: 'users#register'
    post 'user/login' , to: 'users#login'
    
  end


end
