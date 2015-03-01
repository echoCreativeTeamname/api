module Api
  class RecipesController < ApiController

    def index #/v1/recipes
      recipes = ::Recipe.all
      render json: recipes, :each_serializer => RecipeSmallSerializer, root: false, status: 200
    end

    def show #/v1/recipes/:id
      if(recipe = ::Recipe.where(uuid: params[:id]).distinct.first)
				render json: recipe, root: false, status: 200
			else
				render json: {error: true, message: "recipe not found"}, status: 400
			end
    end

  end
end
