class AddCulumnToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :layer, :string

  end
end
