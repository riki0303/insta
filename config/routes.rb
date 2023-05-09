Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'posts#index'

  resource :timeline, only: %i[show]

  resources :posts do
    resource :like, only: %i[create destroy]
    resources :comments, only: %i[new create destroy]
  end

  resource :profile, only: %i[show edit update]

  resources :accounts, only: %i[show] do
    resources :follows, only: %i[create]
    resources :unfollows, only: %i[create]
    resources :followers, only: %i[index]
    resources :followings, only: %i[index]
  end

end
