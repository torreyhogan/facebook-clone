Rails.application.routes.draw do
  get 'friendships/create'
  get 'friendships/destroy'
	root to: 'welcome#index'
 	get '/login', 				to: 'sessions#new'
 	post '/login', 				to: 'sessions#create'
 	delete '/logout', 		to: 'sessions#destroy'
 	get '/signup', 				to: 'users#new'
 	get '/friendrequest', 	to: 'friend_requests#new'
  resources :users
  resources :account_activations, only: [:edit]
  resources :friend_requests, only: [:new, :create ]

end
