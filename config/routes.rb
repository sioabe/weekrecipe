Rails.application.routes.draw do

  get 'updates/new'
  get 'storages/new'

  root to:'toppages#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] do
    member do
      get :like_recipes
      get :buy_storage_recipes
    end
  end  
  resources :recipes, only: [:new] 
  get'recipes/category', to:"recipes#category" 
  get'recipes/random', to:"recipes#random"
  
  resources :likes, only: [:create, :destroy]
  #resources :categories, only:[:new]
  resources :storage_lists, only: [:create, :destroy]
end
