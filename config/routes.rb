Rails.application.routes.draw do
  root 'static_page#home'

  resources :cards, except: [:show]

  resources :users
  resources :user_sessions

  post 'check' => 'static_page#check'

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
