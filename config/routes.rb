Rails.application.routes.draw do
  root to: 'products#index'

  get 'about' => 'about#index'
  
  # Sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Users
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  resources :products, only: [:index, :show]

  # Add this line here
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post   :add_item
    post   :remove_item
  end

  resources :orders, only: [:create, :show]

  namespace :admin do
    root to: 'dashboard#show'
    resources :products, except: [:edit, :update, :show]
    
    # Add resources for categories with only the required actions
    resources :categories, only: [:index, :new, :create]
  end
end
