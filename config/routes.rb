Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :articles do
    collection do
      post :confirm
    end
  end
end
