Rails.application.routes.draw do

  root to:'toppages#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  resources :recipes, only: [:new] 
  get'recipes/category', to:"recipes#category"
  get'recipes/random', to:"recipes#random"
  
  #resources :categories, only:[:new]
end
