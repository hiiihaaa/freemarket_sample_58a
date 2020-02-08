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
      t.integer    :user_id
      # t.references :user, foreign_key: true
      # t.references :category, foreign_key: true
      # t.timestamps
    end
    add_column :products, :size_id, :integer
    add_column :products, :status_id, :integer
    add_column :products, :bearsize_id, :integer
    add_column :products, :sendmethod_id, :integer
    add_column :products, :address_id, :integer
    add_column :products, :period_id, :integer
  end
end
