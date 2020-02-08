Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'index' => 'index#index'
  get "/user_identifications/new" => "user_identifications#new"
  post "/user_identifications/new" => "user_identifications#create"
end
