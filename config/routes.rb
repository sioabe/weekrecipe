Rails.application.routes.draw do

  root to:'toppages#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'login', to: 'sessions#delete'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
end
