Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  root to: 'common_pages#home'

  resources :posts, only: [:create, :destroy,:show] do
    resources :comments
  end

  resources :relationships, only: [:create, :destroy]

  resources :users, only: [:index, :show,:edit,:update] do
    member do
      get :following, :followers
    end
  end

  resources :comments do
    resources :comments
  end

end
