class CreateAddToTColumns < ActiveRecord::Migration[5.2]
  def change
      add_column :products, :size_id, :integer
      add_column :products, :status_id, :integer
      add_column :products, :bearsize_id, :integer
      add_column :products, :sendmethod_id, :integer
      add_column :products, :address_id, :integer
      add_column :products, :period_id, :integer
  end
end
