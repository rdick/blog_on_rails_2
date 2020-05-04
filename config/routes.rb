Rails.application.routes.draw do
  root to: 'posts#index'

  resources :users, only: [:new, :create, :edit, :update]

  resource :session, only: [:new, :create, :destroy]

  resources :posts do
    resources :comments, shallow: true, only: [:create, :destroy]
  end
