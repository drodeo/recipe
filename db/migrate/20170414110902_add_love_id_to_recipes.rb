class AddLoveIdToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :love_id, :integer, default: 0
  end
end
