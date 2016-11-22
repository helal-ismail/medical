Rails.application.routes.draw do
  apipie

  # WEB App
  get 'login' ,to: 'web/session#login'
  post 'login' ,to: 'web/session#login_submit'
  post 'logout' ,to: 'web/session#logout'
  
  get 'home' ,to: 'web/dashboard#home'
  get 'error', to: 'web/error#error'

  # API App
  namespace :api do
    
    namespace :users do
      post 'register'
      post 'login'
    end
    
    namespace :hospitals do
      get 'explore'
      post 'search'
      get 'profile'
    end
    
    namespace :clinics do
      get 'explore'
      post 'search'
      get 'profile'
    end
    
    namespace :appointments do
      post 'new'
    end
    
  end
  
  root 'touch#touch'

end
