Rails.application.routes.draw do

  root 'top#index'
  resources :credit_card, only: [:new, :show] do
    collection do
      post 'show', to: 'credit_card#show'
      post 'pay', to: 'credit_card#pay'
      post 'delete', to: 'credit_card#delete'
    end
  end

  devise_for :users
  root to: "credit_card#new"
  get "credit_card" => "credit_card#new"
  
  resources :products, only: [:new, :edit, :show, :create]
  
  get "purchase_product" => "products#purchase"
  
  resources :users, only: [:edit, :show]

end
