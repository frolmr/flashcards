Rails.application.routes.draw do
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
    resources :cards, except: [:show]
    resources :decks, except: [:show]
    resources :users
    post 'check' => 'static_page#check'
    get 'home' => 'static_page#home'
  end
end
