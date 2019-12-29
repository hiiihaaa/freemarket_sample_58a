Rails.application.routes.draw do
  root 'top#index'
  resources :top do
    resources :products
  end
end
