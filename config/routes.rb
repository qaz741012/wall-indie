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
  resources :users, only: [:index, :show, :edit, :update]

  resources :friendships, only: [:destroy, :create]


  resources :events, only: [:index, :show] do
    collection do
      get :all_events
    end
    member do
      post :follow
      post :unfollow
    end
  end

  root "events#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  #後台admin routes
  namespace :admin do
    resources :places
    resources :events, only: [:index, :edit, :update]
    resources :users, only: [:index, :destroy]
    root "users#index"
  end
end
