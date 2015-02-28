class RecipeSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :summary, :contents, :imageurl, :videourl
  has_many :ingredients
end
