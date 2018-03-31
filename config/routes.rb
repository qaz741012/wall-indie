Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :artists do
    member do
      post :follow
      post :unfollow
      post :favorite
      post :unfavorite
    end
  end
  resources :users, only: %i[index show edit update]

  resources :friendships, only: %i[destroy create]

  resources :events, only: %i[index show] do
    collection do
      get :all_events
    end
    member do
      post :follow
      post :unfollow
    end
  end

  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # admin routes
  namespace :admin do
    resources :places, :events
    resources :users, only: %i[index destroy]
    resources :artists, only: %i[index edit update]
    root 'users#index'
  end
end
