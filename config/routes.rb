Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# toppages
	root to: "toppages#index"

# users
  get "signup", to: "users#new"
  resources :users, only: [:show,  :new, :create]
  
# sessions
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

# items
  resources :items, only: [:new]

end
