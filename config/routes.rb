Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get :drafts
      get :posts
      get :replies
      get :collects
      get :friends
    end
  end
  resources :friendships, only: [:create, :destroy] do
    member do
      patch :ignore
      patch :connect
    end
  end
  resources :posts do 
    resources :replies, only: [:create, :destroy, :edit, :update]
    collection do
      get :feeds
    end
    member do
      post :collect
      post :uncollect   
    end    
  end
  resources :categories, only: :show
  root "posts#index"

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :categories
    root "categories#index"
  end

end
