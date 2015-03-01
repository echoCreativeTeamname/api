module Api
  class RecipesController < ApiController

    def index #/v1/recipes
      recipes = ::Recipe.all
      render json: recipes, :each_serializer => RecipeSmallSerializer, root: false, status: 200
    end

    def show #/v1/recipes/:id
      if(recipe = ::Recipe.where(uuid: params[:id]).first)
				render json: recipe, root: false, status: 200
			else
				render json: {error: true, message: "recipe not found"}, status: 400
			end
    end


    def storechain #/v1/recipes/:id/storechain/:storechain_id
      if(recipe = ::Recipe.where(uuid: params[:id]).first)
        if(storechain = ::Storechain.where(uuid: params[:storechain_id]).distinct.first)
          render_products = []
          recipe.ingredients.each do |ingredient|
            render_products << {
              ingredient: ::IngredientSerializer.new(ingredient, root: false).as_json, 
              product: ::ProductSmallSerializer.new(ingredient.products.where(storechain: storechain).first, root: false).as_json
            }
          end

          render json: render_products, root: false, status: 200
        else
          render json: {error: true, message: "storechain not found"}, status: 400
        end
			else
				render json: {error: true, message: "recipe not found"}, status: 400
			end
    end

  end
end
