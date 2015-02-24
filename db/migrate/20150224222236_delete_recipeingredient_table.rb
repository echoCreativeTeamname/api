class DeleteRecipeingredientTable < ActiveRecord::Migration
  def up
    drop_table :recipeingredient
  end
end
