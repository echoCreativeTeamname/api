class ChangeRecipeTable < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.string :type
      t.integer :portions
      t.float :cookingtime
    end
  end
end
