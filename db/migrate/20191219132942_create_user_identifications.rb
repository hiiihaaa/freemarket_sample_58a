class CreateUserIdentifications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_identifications do |t|

      t.timestamps
    end
  end
end
