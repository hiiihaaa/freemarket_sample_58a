class Images < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string "image"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end