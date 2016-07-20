Rails.application.routes.draw do
  devise_for :users

  resources :auctions, only: [:index, :new, :create, :destroy, :show] do
    member do
      post :bid
      post :draw
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'auctions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
