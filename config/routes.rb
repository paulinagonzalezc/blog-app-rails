Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy], param: :id do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  namespace :api do
  namespace :v1 do
    resources :users, only: [] do
      resources :posts, only: [:index], format: :json do
        resources :comments, only: [:index, :create], format: :json
      end
    end
  end
  end

  root 'users#index'
end
