Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get :draft
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do 
    collection do
      get :feeds
    end
  end
  root "posts#index"

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :categories
    root "categories#index"
  end

end
