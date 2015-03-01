class ChangeRecipeTable < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.string :dish_type
      t.integer :portions
      t.float :cookingtime
    end
  end
end
