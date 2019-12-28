class CreateMoreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :moredit_cards do |t|

      t.timestamps
    end
  end
end
