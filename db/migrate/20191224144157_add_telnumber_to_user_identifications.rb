class AddTelnumberToUserIdentifications < ActiveRecord::Migration[5.2]
  def change
    add_column :user_identifications, :telnumber, :string
  end
end
