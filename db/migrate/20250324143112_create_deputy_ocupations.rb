class CreateDeputyOcupations < ActiveRecord::Migration[8.0]
  def change
    create_table :deputy_ocupations do |t|
      # Basic information
      t.string :title # Title (e.g., "Professor de Prática de Ensino de História")
      t.string :entity # Name of the entity
      t.string :entity_state # Entity state (e.g., "RJ")
      t.string :entity_country # Entity country (e.g., "BRASIL")
      t.integer :start_year # Start year (e.g., 1997)
      t.integer :end_year # End year (e.g., 1998)

      t.references :deputy, null: false, foreign_key: true

      # Timestamps
      t.timestamps
    end

    # Adding indexes for searchable fields
    add_index :deputy_ocupations, :title
    add_index :deputy_ocupations, :entity
    add_index :deputy_ocupations, :entity_state
    add_index :deputy_ocupations, :start_year
  end
end
