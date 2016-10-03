Rails.application.routes.draw do
  root 'static_page#home'

  resources :cards, except: [:show]
  resources :decks, except: [:show]

  resources :users
  resources :user_sessions

  post 'check' => 'static_page#check'

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
