Rails.application.routes.draw do
  # Root route
  root to: 'products#index'

  # Non-admin routes
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  resource :cart, only: [:show] do
    post :add_item
    post :remove_item
  end
  resources :orders, only: [:create, :show]

  # Static pages
  get 'about', to: 'about#index'

  # User routes
  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, except: [:new]

  # Admin namespace
  namespace :admin do
    root to: 'dashboard#show'
    resources :products
    resources :categories, only: [:index, :new, :create]
  end
end
