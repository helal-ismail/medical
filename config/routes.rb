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

  get 'dashboard', to: 'web/dashboard/admin#index'

  get 'hospitals', to: 'web/dashboard/hospitals#index'
  get 'hospitals/new', to: 'web/dashboard/hospitals#new'
  get 'hospitals/:id', to: 'web/dashboard/hospitals#dashboard'

  get 'clinics', to: 'web/dashboard/clinics#index'
  get 'hospitals/:id/clinics', to: 'web/dashboard/clinics#index'

  get 'clinics/new', to: 'web/dashboard/clinics#new'
  get 'clinics/:id', to: 'web/dashboard/clinics#dashboard'

  get 'doctors', to: 'web/dashboard/doctors#index'
  get 'hospitals/:id/doctors', to: 'web/dashboard/doctors#index'
  get 'clinics/:id/doctors', to: 'web/dashboard/doctors#index'

  get 'appointments', to: 'web/dashboard/appointments#index'
  get 'clinics/:id/appointments/', to: 'web/dashboard/appointments#index'
  get 'clinics/:id/appointments/:date', to: 'web/dashboard/appointments#index'

  # API App
  namespace :api do

    namespace :users do
      post 'register'
      post 'login'
      post 'edit'
      post 'change_password'
      post 'social_login'
      get 'edit_local'
    end

    namespace :doctors do
      get 'profile'
      post 'search'
      post 'add_feedback'
      get 'get_feedback'
      get 'clinics'
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
      post 'assign_doctor'

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
      post 'search'
      post 'state'
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
      post 'set_seen'
      get 'get_counter'
    end

    namespace :attachments do
      post 'upload'
    end

  end

  root 'web/dashboard#home'

end
