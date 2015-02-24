class CreateJoinTableStoreUser < ActiveRecord::Migration
  def change
    create_join_table :stores, :users do |t|
      t.index :user_id
      t.index :store_id
    end
  end
end
