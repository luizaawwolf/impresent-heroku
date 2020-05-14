Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meditations 
  resources :users
  resources :admins

  root 'sessions#welcome'

  get 'login', to: 'sessions#new'
  get 'welcome', to: 'sessions#welcome'
  get 'meditations/index'
  get 'admins/new' => 'admins#new'
  get 'admins/create'
  get 'authorized', to: 'sessions#page_requires_login'

  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#logout'
  post 'users/validate' => 'users#validate'
  post 'meditations/numberofMeds' => 'meditations#numberOfMeds'
end
