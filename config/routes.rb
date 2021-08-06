Rails.application.routes.draw do
  root "sessions#home"

#  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}


  post '/name_order' => 'books#name_order'

  #signup
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  #login
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  #logout
  delete '/logout' => 'sessions#destroy'

  resources :books
  resources :tags
  resources :users
  resources :notes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
