Rails.application.routes.draw do
  root to: 'subs#index'
  resources :users, except: :index
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:new, :create, :index] do
    resources :comments, only: [:new]
  end

  resources :comments, only: :create
end
