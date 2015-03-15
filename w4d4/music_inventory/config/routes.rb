Rails.application.routes.draw do
  root to: redirect('/bands')

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:new, :index]
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new, :index]
  end

  resources :tracks, except: [:new, :index]
end
