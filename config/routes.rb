Rails.application.routes.draw do
  get 'activities' => 'activities#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  scope module: "home" do
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
    post 'logout' => 'user_sessions#destroy', :as => :logout
    get 'login' => 'user_sessions#new', :as => :login
    resources :user_sessions
  end

  scope module: "dashboard" do
    root 'static_page#home'
    post 'find_flickr_images' => 'cards#find_on_flickr'
    resources :cards, except: [:show]
    resources :decks, except: [:show]
    resources :users
    post 'check' => 'static_page#check'
    get 'home' => 'static_page#home'
    get 'batch_download' => 'load_cards#new'
    get 'load_word_pairs' => 'load_cards#load_word_pairs'
  end
end
