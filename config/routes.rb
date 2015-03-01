Rails.application.routes.draw do
  # See how all your routes lay out with "rake routes".
  # POST for create, PUT for update, PATCH for upsert (update and insert)

  # Error pages
  match '/404', via: :all, to: 'errors#not_found'
  match '/422', via: :all, to: 'errors#server_error'
  match '/500', via: :all, to: 'errors#server_error'

  namespace :api do

    # Root of the api
    root 'index#index'

    # Api version v1_beta
    get "/v1" => "index#v1"
    scope "/v1" do

      # stores
      get "/stores" => "stores#index"
      get "/stores/:id" => "stores#show"

      # storechains
      get "/storechains" => "storechains#index"
      get "/storechains/:id" => "storechains#show"
      get "/storechains/:id/stores" => "storechains#stores"
      get "/storechains/:id/products" => "storechains#products"

      # products
      get "/products" => "products#index"
      get "/products/:id" => "products#show"
      get "/products/:id/storechain" => "products#storechain"
      
      #recipes
      get "/recipes" => "recipes#index"
      get "/recipes/:id" => "recipes#show"

      # user
      get "/user" => "user#index"
      get "/user/:id" => "user#show", as: 'userinfo'
      post "/user" => "user#create"
      post "/user/:id/edit" => "user#update"
      post "/user/:id/settings" => "user#update_settings"
      post "/user/:id/address" => "user#update_address"
      delete "/user/:id" => "user#destroy"
      post "/authenticate" => "user#login"
      delete "/authenticate" => "user#logout"

      # user-information
      get "/user/:id/stores" => "user_information#stores"
      get "/user/:id/recipes" => "user_information#recipes"
      delete "/user/:id/recipes" => "user_information#recipes_delete"
      get "/user/:id/recipes/:recipe_id" => "user_information#recipe"
      delete "/user/:id/recipes/:recipe_id" => "user_information#recipe_delete"

    end
  end
end
