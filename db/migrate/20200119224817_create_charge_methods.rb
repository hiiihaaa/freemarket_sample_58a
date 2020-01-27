class CreateChargeMethods < ActiveRecord::Migration[5.2]
  def change
      create_table :charge_mothods do |t|
      t.string :layer
      t.string :ancestry ,index: true
    end
  end
end
