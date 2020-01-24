class CreateSendAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :send_areas do |t|
      t.string :area
      t.timestamps
    end
  end
end
