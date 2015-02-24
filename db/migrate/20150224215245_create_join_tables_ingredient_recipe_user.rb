class CreateJoinTablesIngredientRecipeUser < ActiveRecord::Migration
  def change
    create_join_table :recipes, :users do |t|
      t.index :recipe_id
      t.index :user_id
    end

    create_join_table :recipes, :ingredients do |t|
      t.index :recipe_id
      t.index :ingredient_id
      t.string :amount
    end
  end
end
