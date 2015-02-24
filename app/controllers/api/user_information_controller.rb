module Api
  # All functions for users that are not associated with changing/deleting/creating user settings TODO
  class UserInformationController < ApiController

    # All nearbye stores. will only answer when address has been set TODO
    def stores # /v1/user/:id/stores (GET)

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

    end

    # delete specific recipe for this user
    def recipe_delete # /v1/user/:id/recipes/:recipe_id (DELETE)
      params[:recipes] = params[:recipe_id]
      recipes_delete
    end



  end
end
