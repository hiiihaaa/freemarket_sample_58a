Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'index' => 'index#index'
  get "/user_identification/new" => "user_identification#new"
  post "/user_identification/create" => "user_identification#create"
end
