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
    post 'user' , to: 'users#register'
    post 'user/login' , to: 'users#login'
  end
  
  root 'touch#touch'

end
