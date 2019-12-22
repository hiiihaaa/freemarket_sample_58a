class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string   :name, index: true, length: { in: 1..40 }
      t.text     :detail
      t.string   :brand
      t.integer  :price, null: false
      t.timestamps
    end
  end
end
