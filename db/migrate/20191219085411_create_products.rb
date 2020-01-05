class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :name
      t.string  :size
      t.string  :status
      t.string  :shipping_fee
      t.string  :shipping_method
      t.string  :shipping_from
      t.string  :shipping_date
      t.integer :price
      t.string  :brand
      t.string  :purchase_status
      t.integer :user_id
      t.text    :product_detail
      # t.timestamps
    end
  end
end
