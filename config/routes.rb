Rails.application.routes.draw do
  root 'static_page#home'

  resources :cards, except: [:show]

  post 'check' => 'static_page#check'
end
