class CreateProductPeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :product_periods do |t|
      t.integer :product_id
      t.integer :send_periods_id
      t.timestamps
    end
  end
end
