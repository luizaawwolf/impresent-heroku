Rails.application.routes.draw do
  get 'session/new'
  get 'session/create'
  get 'session/login'
  get 'session/welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meditations 
  resources :users
  resources :admins

  root 'session#welcome'

  get 'login', to: 'session#new'
  get 'welcome', to: 'session#welcome'
  get 'meditations/index'
  get 'admins/new' => 'admins#new'
  get 'admins/create'
  get 'authorized', to: 'session#page_requires_login'

  post 'login', to: 'session#create'
  post 'logout', to: 'session#logout'
  post 'users/create', to: 'users#create'
  post 'users/validate' => 'users#validate'
  post 'meditations/numberofMeds' => 'meditations#numberOfMeds'
  post 'meditations'=>'meditations#create'
end
