Rails.application.routes.draw do

  root 'top#index'
  get "users" => "users#index"

  # View作成用無理やりルーティング。あとで消す。kajitani
  get "users/destroy"

  devise_scope :user do
    post 'users', to: 'devise/registrations#create'
  end
  devise_for :users

  resources :users, only: [:edit, :show]

  resources :signups, only: [:index] do
    collection do
      get 'step1'   
      post 'step1', to: 'signups#step1_validates' 
      get 'step2'  
      post 'step2', to: 'signups#step2' 
      resource :phones,only: [:new] do
        collection do
      post 'step3', to: "signups#step3"
      get  "step4_new", to: "signups#step4_new"
      post "step4", to: "signups#step4"
       end
      end
    end   
  end    

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
