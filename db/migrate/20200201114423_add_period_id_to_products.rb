class AddPeriodIdToProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :period_id, :integer
    add_column :products, :period_id, :integer, foreign_key: true
  end
end
