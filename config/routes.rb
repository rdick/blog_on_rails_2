Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    resources :comments, shallow: true, only: [:create, :destroy]
  end
end
