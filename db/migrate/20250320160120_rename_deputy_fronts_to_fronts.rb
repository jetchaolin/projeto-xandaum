class RenameDeputyFrontsToFronts < ActiveRecord::Migration[8.0]
  def change
    rename_table :deputy_fronts, :fronts
  end
end
