Rails.application.routes.draw do

  get 'sessions/new'
  resources :microposts
  resources :users
  resources :sessions
  resources :microposts do
    resources :comments
    delete :delete_attachment
  end
  get "/auth/google_oauth2/callback", to: "sessions#create"
  get "/login", to: redirect("/auth/google_oauth2")
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#new'
  
  get '/users/current' => "users#obtain_current_user"
  post '/microposts/:id/vote' => "microposts#vote", as: :vote
  post '/microposts/:id/watch' => "microposts#watch", as: :watch
  put '/microposts/:id/status' => "microposts#update_status", as: :update_status
end
