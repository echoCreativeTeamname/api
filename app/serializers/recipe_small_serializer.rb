class RecipeSmallSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :summary, :imageurl, :videourl, :dish_type, :portions, :cookingtime, :estimated_cost
end
