Rails.application.routes.draw do

  root 'top#index'
  devise_for :users
  devise_scope :user do
    post 'sign_up', to: 'devise/registrations#create'
  end
 
  resources :users, only: [:edit, :show]

  resources :credit_cards, only: [:new, :show] do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'pay', to: 'credit_cards#pay'
      post 'delete', to: 'credit_cards#delete'
    end
  end

  resources :products, only: [:index, :new, :create, :edit, :show] do
    resources :likes, only: [:create]
  end
  get "purchase_product" => "products#purchase"
  resources :comments, only: [:index, :create] 

end
