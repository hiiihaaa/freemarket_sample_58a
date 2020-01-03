# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :nickname,           null: false
      t.string :firstname,          null: false
      t.string :lastname,           null: false
      t.string :firstname_kana,     null: false
      t.string :lastname_kana,      null: false
      t.datetime    :birthday,               null: false
      t.string :image             
    end

    # add_index :users, :email,                unique: true
    # add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
