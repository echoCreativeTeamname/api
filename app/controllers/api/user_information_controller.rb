module Api
  # All functions for users that are not associated with changing/deleting/creating user settings
  class UserInformationController < ApiController

    # All nearbye stores. will only answer when address has been set
    def stores # /v1/user/:id/stores (GET)
      if(has_authentication())
        if(!@auth_user.stores.empty?)
          render json: @auth_user.stores.includes(:chain), root: "stores", status: 200, :each_serializer => StorefullSerializer
        elsif(!@auth_user.latitude)
          render json: {error: true, message: "user hasn't set a location"}, status: 400
        else
          render json: {error: true, message: "no nearbye stores were found, try again later"}, status: 500
        end
      end
    end

    # list of recipes for the user TODO
    def recipes # /v1/user/:id/recipes (GET)
      render json: {recieved: true}
    end

    # delete recipe in list of user recipes TODO
    def recipes_delete # /v1/user/:id/recipes (DELETE)

    end

    # get full recipe for specific recipe id TODO
    def recipe # /v1/user/:id/recipes/:recipe_id (GET)
      if(has_authentication(params[:id]))

      end
    end

    # delete specific recipe for this user
    def recipe_delete # /v1/user/:id/recipes/:recipe_id (DELETE)
      params[:recipes] = params[:recipe_id]
      recipes_delete
    end



  end
end
