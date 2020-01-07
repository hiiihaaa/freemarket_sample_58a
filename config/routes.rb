Rails.application.routes.draw do

  root 'top#index'
  resources :credit_cards, only: [:new, :show] do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end

  devise_for :users

  
  resources :products, only: [:new, :edit, :show, :create]
  get "purchase_product" => "products#purchase"
  
  resources :users, only: [:edit, :show]

end
