class CreateDeputyFronts < ActiveRecord::Migration[8.0]
  def change
    create_table :deputy_fronts do |t|
      t.string :external_id
      t.string :title

      t.timestamps
    end

    add_index :deputy_fronts, :external_id, unique: true
  end
end
