Rails.application.routes.draw do
  #get ‘login’, to: ‘sessions#new’, as: ‘login’
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
end
