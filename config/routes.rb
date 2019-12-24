Rails.application.routes.draw do
  get 'user_identifications/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'index' => 'index#index'
  get "/user_identification/new" => "user_identification#new"
  post "/user_identifications/new" => "user_identifications#create"
end
