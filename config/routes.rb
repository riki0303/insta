require 'sidekiq/web'

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'posts#index'

  resource :timeline, only: %i[show]

  resources :posts do
    resource :like, only: %i[show create destroy]
    resources :comments, only: %i[index new create destroy]
  end

  resource :profile, only: %i[show edit update]

  resources :accounts, only: %i[show] do
    resource :follow, only: %i[show create]
    resource :unfollow, only: %i[show create]
    resources :followers, only: %i[index]
    resources :followings, only: %i[index]
  end
end
