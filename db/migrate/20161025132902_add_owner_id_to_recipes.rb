class AddOwnerIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :owner_id, :integer
  end
end
