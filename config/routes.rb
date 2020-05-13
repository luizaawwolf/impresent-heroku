Rails.application.routes.draw do
  resources :meditations 
  resources :users

  root 'home#show'

  get 'home/show'
  get 'meditations/index'
  get 'dashboard' => 'meditations#index'
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  get '/logout' => 'logout#logout'

  post 'users/validate' => 'users#validate'
  post 'meditations/numberofMeds' => 'meditations#numberOfMeds'


end
