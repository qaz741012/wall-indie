Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :artists do
    member do
      post :follow
      post :unfollow
      post :favorite
      post :unfavorite
    end
  end

  resources :events

  root "artists#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #後台admin routes
  namespace :admin do
    resources :events, only: [:index, :edit, :update]
    resources :users, only: [:index, :destroy]
    root "users#index"
  end
end
