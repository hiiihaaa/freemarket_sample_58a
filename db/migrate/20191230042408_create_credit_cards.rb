class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    drop_table :credit_cards
    create_table :credit_cards do |t|
      t.integer :user_id, foreign_key: true
      t.string :customer_id, null: false
      t.string :card_id, null: false
    end
  end
end
