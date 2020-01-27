class CreateSendMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :send_methods do |t|

      t.timestamps
    end
  end
end
