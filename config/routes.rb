Rails.application.routes.draw do
  devise_for :users
  resources :artists

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events, only: [:index]
  root "events#index"

  #後台admin routes
  namespace :admin do
    resources :events, only: [:index, :edit, :update]
    resources :users, only: [:index, :destroy]
    root "users#index"
  end
end
