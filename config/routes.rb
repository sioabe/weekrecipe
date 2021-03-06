Rails.application.routes.draw do

  resources :rakuten_scrapings, only: [:new, :update, :destroy, :create] do
    member do
      get :edit
    end
  end
  
  get 'rakuten_scrapings/add_scraping', to:"rakuten_scrapings#add_scraping" 
  
  resources :lists, only: [:new, :create, :destroy, :show]

  get 'updates/new'
  get 'storages/new'
  
  #管理者画面
  resources :supervisors, only: [:show, :new, :create] do
    member do
      get :foods 
      get :recipes
      get :users
      get :rakuten_scrapings
    end
  end
  #管理者ログイン画面
  get 'supervisor_login', to: 'supervisor_sessions#new'
  post 'supervisor_login', to: 'supervisor_sessions#create'
  delete 'supervisor_logout', to: 'supervisor_sessions#destroy'

  resources :foods, only: [:update, :destroy] do
    member do
      get :edit
    end
  end

  root to:'toppages#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :update] do
    member do
      get :like_recipes
      get :buy_storage_recipes
      get :edit
    end
  end  
  resources :recipes, only: [:new,:update] do
    member do
      get :edit
    end
  end
  get'recipes/category', to:"recipes#category" 
  get'recipes/random', to:"recipes#random"
  get'recipes/search', to:"recipes#search"
  
  resources :likes, only: [:create, :destroy]

  resources :storage_lists, only: [:create, :destroy]
end
