Rails.application.routes.draw do
  root 'static_page#home'

  resources :cards, only: [:index]
end