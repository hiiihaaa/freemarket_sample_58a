class CreateProductSendAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :product_send_areas do |t|
      t.integer :product_id
      t.integer :send_areas_id
      t.timestamps
    end
  end
end
