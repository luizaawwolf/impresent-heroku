Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meditations 
  resources :users
  get 'meditations/index'
  root 'meditations#index'

  post 'users/validate' => 'users#validate'

  post 'meditations/numberofMeds' => 'meditations#numberOfMeds'
end
