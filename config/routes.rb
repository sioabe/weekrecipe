Rails.application.routes.draw do
  
  resources :lists, only: [:new, :create, :destroy, :show]

  get 'updates/new'
  get 'storages/new'
  
  #管理者画面
  resources :supervisors, only: [:show, :new, :create] do
    member do
      get :foods 
      get :recipes
      get :users
    end
  end
  #管理者ログイン画面
  get 'supervisor_login', to: 'supervisor_sessions#new'
  post 'supervisor_login', to: 'supervisor_sessions#create'
  delete 'supervisor_logout', to: 'supervisor_sessions#destroy'

  resources :foods, only: [:update] do
    member do
      get :edit
    end
  end

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
  resources :recipes, only: [:new,:update] do
    member do
      get :edit
    end
  end
  get'recipes/category', to:"recipes#category" 
  get'recipes/random', to:"recipes#random"
  
  resources :likes, only: [:create, :destroy]
  #resources :categories, only:[:new]
  resources :storage_lists, only: [:create, :destroy]
end
