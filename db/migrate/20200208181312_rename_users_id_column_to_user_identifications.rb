class RenameUsersIdColumnToUserIdentifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_identifications, :users_id, :user_id
  end
end
