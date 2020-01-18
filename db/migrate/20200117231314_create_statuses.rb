class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    add_column :send_areas, :address_id, :integer

  end
end
