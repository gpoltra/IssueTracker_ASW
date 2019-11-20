Rails.application.routes.draw do
  get '/users/current_user' => "users#the_current_user", as: :current_user

  resources :microposts
  resources :users
  resources :sessions
  resources :microposts do
    resources :comments
  end
  get "/auth/google_oauth2/callback", to: "sessions#create"
  get "/login", to: redirect("/auth/google_oauth2")
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#new'
  
  post '/microposts/:id/vote' => "microposts#vote", as: :vote
  post '/microposts/:id/watch' => "microposts#watch", as: :watch
  
  put '/microposts/:id/status' => "microposts#update_status", as: :update_status
end
