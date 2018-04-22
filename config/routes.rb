Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"

  namespace :admin do
    resources :users, only: [:index, :update]
    resources :categories
    root "categories#index"
  end

end
