class AddChargemethodIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :charge_method_id, :integer, foreign_key: true
  end
end
