Rails.application.routes.draw do
  root "sessions#home"

  #signup
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  #login

  #logout
  delete '/logout' => 'sessions#destroy'

  resources :books
  resources :tags
  resources :users
  resources :notes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
