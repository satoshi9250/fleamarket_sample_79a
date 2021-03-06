Rails.application.routes.draw do

  root 'products#index'
  resources :products, only: [:new, :show, :create, :edit, :update, :destroy] do 
    collection do
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
    resources :purchases do
      member do
        get  "buy"
        post "pay"
      end
    end
    resources :comments, only: [:create,:edit,:destroy, :update]
  end
  resources :categories
  resources :images

  resources :credit_cards, only: [:new, :create, :show, :destroy]  

  resources :users, only: [:index, :edit]
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'delivery_address', to: 'users/registrations#new_delivery_address'
    post 'delivery_address', to: 'users/registrations#create_delivery_address'
  end


end
