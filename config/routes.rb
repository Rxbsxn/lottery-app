Rails.application.routes.draw do
  devise_for :users
resources :auctions, only: [:index, :new, :create, :destroy, :show]

  root 'auctions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
