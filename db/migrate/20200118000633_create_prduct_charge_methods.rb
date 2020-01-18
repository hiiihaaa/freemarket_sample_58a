class CreatePrductChargeMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :prduct_charge_methods do |t|
      t.integer :method_id
      t.timestamps
    end
  end
end
