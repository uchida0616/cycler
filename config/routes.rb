Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root to: 'users#new'
  resources :favorites, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
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
