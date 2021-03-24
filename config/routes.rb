Rails.application.routes.draw do

  root 'welcome#index'
  resources :users, only: [:new, :create]
  resources :dashboard, only: [:index]
  # resources :sessions, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get'/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
end
