Rails.application.routes.draw do
  root 'index#index'
  resources :index, only: [:index, :show]
end
