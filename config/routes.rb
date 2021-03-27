Rails.application.routes.draw do

  root 'welcome#index'
  resources :dashboard, only: [:index]

  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get'/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
end
