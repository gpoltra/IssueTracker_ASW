Rails.application.routes.draw do
  resources :microposts
  resources :users
  resources :microposts do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#new'
  
  put '/issues/:id/status' => "issues#update_status", as: :update_status
  post '/issues/:id/vote' => "issues#vote", as: :vote
  get '/users/current_user' => "users#the_current_user", as: :current_user
end
