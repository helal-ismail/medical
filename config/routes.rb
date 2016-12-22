Rails.application.routes.draw do
  apipie

  # WEB App
  get 'login' ,to: 'web/session#login'
  post 'login' ,to: 'web/session#login_submit'
  post 'logout' ,to: 'web/session#logout'

  get 'home' ,to: 'web/dashboard#home'
  get 'error', to: 'web/error#error'

  get 'hello', to: 'web/dashboard#hello'
  get 'hend' , to: 'web/dashboard#hend'


  get 'clinics', to: 'web/dashboard/clinics#index'
  # API App
  namespace :api do

    namespace :users do
      post 'register'
      post 'login'
      post 'edit'
      post 'change_password'
      post 'social_login'
    end

    namespace :doctors do
      get 'profile'
      post 'search'
      post 'add_feedback'
      get 'get_feedback'
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
      get 'specializations'
    end

    namespace :appointments do
      post 'new'
      post 'edit'
      post 'cancel'
      get 'show'
      post 'add_notes'
      get 'by_patient'
      get 'by_doctor_and_clinic'
      get 'by_all_params'
    end

    namespace :patients do
      get 'profile'
      get 'appointments'
      post 'search'
    end

    namespace :schedules do
      post 'new'
      post 'edit'
      post 'cancel'
      get 'show'
    end

    namespace :notifications do
      post 'register_device'
      post 'send_push'
      get 'user_notifications'
    end

  end

  root 'touch#touch'

end
