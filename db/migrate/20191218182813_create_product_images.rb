class CreateProductImages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_images do |t|
      t.integer :product_id, foreign_key: true
      t.string  :image_url
      # t.timestamps
    end
  end
end
