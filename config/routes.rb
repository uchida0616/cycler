Rails.application.routes.draw do
  resources :users, only: [:new]
  resources :articles do
    collection do
      post :confirm
    end
  end
end
