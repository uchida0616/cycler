Rails.application.routes.draw do
  root to: 'users#new'
  resources :favorites, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    member do
      get :favorite_article
    end
  end
  resources :articles do
     collection do
       post :confirm
    end
  end
end
