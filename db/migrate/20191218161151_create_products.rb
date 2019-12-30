class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :name
      t.text       :description
      t.string     :size
      t.string     :status
      t.string     :shipping_fee
      t.string     :shipping_method
      t.string     :shipping_from
      t.string     :shipping_date
      t.integer    :price
      t.string     :brand
      t.string     :purchase_status
      t.integer    :category_id, foreign_key: true
      # t.references :user, foreign_key: true
      # t.references :category, foreign_key: true
      # t.timestamps
    end
  end
end
