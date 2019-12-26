Rails.application.routes.draw do
  root 'index#index'
  resources :index do
    resources :products
  end
end
