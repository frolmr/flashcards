Rails.application.routes.draw do
  root 'static_page#home'

  resources :cards, except: [:show]
end