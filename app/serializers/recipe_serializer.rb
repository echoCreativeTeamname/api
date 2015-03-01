class RecipeSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :summary, :contents, :imageurl, :videourl, :dish_type, :portions, :cookingtime, :ingredients

  def ingredients
    ingredients_array = []

    object.recipeingredients.each do |recipeingredient|
      ingredients_array << {
        uuid: recipeingredient.ingredient.uuid,
        name: recipeingredient.ingredient.name,
        amount: recipeingredient.amount
      }
    end

    return ingredients_array
  end

end
