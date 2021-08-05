Rails.application.routes.draw do
  root to: 'users#new'
  resources :favorites, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    end
  end
  resources :users do
    member do
      get :favorite_article
    end
  end
  resources :articles do
    resources :comments
     collection do
       post :confirm
    end
  end
end
