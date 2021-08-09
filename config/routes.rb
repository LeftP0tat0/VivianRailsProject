Rails.application.routes.draw do

#  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}

  post '/index' => 'books#index'
  get '/index' => 'books#index'
  get '/auth/github/callback' => 'sessions#create' 
  post '/users' => 'users#create'

  #signup
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  #login
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  #logout
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:show, :index] do
    resources :books, only: [:show, :index, :new]
  end
  resources :books
  resources :notes
  resources :tags


  root "sessions#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
