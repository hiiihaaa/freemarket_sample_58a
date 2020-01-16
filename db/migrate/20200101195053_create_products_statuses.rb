class CreateProductsStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :products_statuses do |t|
      t.integer :product_id
      t.integer :status_id
      t.timestamps
    end
  end
end
