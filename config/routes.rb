Rails.application.routes.draw do
  devise_for :users

  get 'auctions/new' => 'auctions#new'
  get 'auctions' => 'auctions#index'
  root 'auctions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
