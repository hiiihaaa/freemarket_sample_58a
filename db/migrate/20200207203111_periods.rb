class Periods < ActiveRecord::Migration[5.2]
  def change
    create_table :periods do |t|
    t.string :period
    t.string :ancestry ,index: true
    end
  end
end