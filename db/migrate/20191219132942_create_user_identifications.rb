class CreateUserIdentifications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_identifications do |t|
      t.integer :post_number,null: false
      t.string :prefecture, null: false
      t.string :city,null: false
      t.string :block,null: false
      t.string :building,null: false
      t.integer :users_id,null: false
      t.timestamps
    end
  end
end
