Rails.application.routes.draw do
  # See how all your routes lay out with "rake routes".
  # POST for create, PUT for update, PATCH for upsert (update and insert)
  #
  #
  #

  match '/404', via: :all, to: 'errors#not_found'
  match '/422', via: :all, to: 'errors#server_error'
  match '/500', via: :all, to: 'errors#server_error'

  root 'index#index' # Root of the website

  get "/v1" => "index#v1"
  scope "/v1" do # Api version v1_alpha

    # stores
    resources :stores, only: [:index, :show]

    # user
    get "/user" => "user#index"
    get "/user/:id" => "user#show", as: 'userinfo'
    post "/user" => "user#create"
    post "/user/:id/settings" => "user#update_settings"
    post "/user/:id/address" => "user#update_address"
    delete "/user/:id" => "user#destroy"
    post "/authenticate" => "user#login"
    delete "/authenticate" => "user#logout"

    # user-information
    get "/user/:id/recipes" => "user_information#recipes"
    delete "/user/:id/recipes" => "user_information#recipes_delete"
    get "/user/:id/recipes/:recipe_id" => "user_information#recipe"
    delete "/user/:id/recipes/:recipe_id" => "user_information#recipe_delete"


  end
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
