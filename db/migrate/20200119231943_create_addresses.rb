class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :address_id
      t.string :name

      t.timestamps
    end
  end
end
