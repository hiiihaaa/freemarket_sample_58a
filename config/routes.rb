Rails.application.routes.draw do
  get 'products/new'
  root 'top#index'
end
