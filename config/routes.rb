Rails.application.routes.draw do
  # post 'friendships/create', to: 'friendships#create'
  delete 'friendships/destroy', to: 'friendships#destroy'
  # get 'friend_requests/destroy'
	root to: 'welcome#index'
 	get '/login', 				to: 'sessions#new'
 	post '/login', 				to: 'sessions#create'
 	delete '/logout', 		to: 'sessions#destroy'
 	get '/signup', 				to: 'users#new'
  resources :users
  resources :account_activations, only: [:edit]
  resources :friend_requests, only: [:new, :create, :destroy ]
  resources :friendships, only: [:new, :create, :destroy]

end
