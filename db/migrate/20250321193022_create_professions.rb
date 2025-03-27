class CreateProfessions < ActiveRecord::Migration[8.0]
  def change
    create_table :professions do |t|
      # Basic information
      t.datetime :datetime # Data e hora (e.g., "2018-08-14T16:36")
      t.integer :profession_type_code, null: false # Código do tipo de profissão (e.g., 221)
      t.string :title, null: false # Título da profissão (e.g., "Escritor")

      # Timestamps
      t.timestamps
    end

    # Adding indexes for searchable fields
    add_index :professions, :profession_type_code
    add_index :professions, :title
  end
end
