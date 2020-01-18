class RenameTablenameToChargemethod < ActiveRecord::Migration[5.2]
  def change
    rename_table :charge_mothods, :charge_methods
  end
end
