Rails.application.routes.draw do

  root 'top#index'
  
  get 'top/search', to: 'products#search'

  
  get "users" => "users#index"

  devise_scope :user do
    post 'users', to: 'devise/registrations#create'
  end
  devise_for :users
  resources :users, only: [:edit, :show]

  resources :credit_cards, only: [:new, :show] do
    collection do
      post 'show', to:   'credit_cards#show'
      post 'pay', to:    'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end

  resources :products do
    member do
      get :purchase
      post :pay, to: "product#pay"
    end

    collection do
      get "cate_children" 
      get "grand_children" 
    end

    resources :likes, only: [:create]
  end
  
  resources :comments, only: [:index, :create] 


end
