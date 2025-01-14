Rails.application.routes.draw do
  root 'welcome#index'

  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get'/logout', to: 'session#destroy'
  delete '/logout', to: 'session#destroy'

  get '/dashboard', to: 'dashboard#show'

  get '/discover', to: 'discover#show'

  post '/friendships', to: 'friendships#create'

  resources :movies, only: [:index, :show]

  # resources :viewing_party, only: [:new, :create]
  resources :parties, only: [:new, :create], controller: "viewing_parties"
end
