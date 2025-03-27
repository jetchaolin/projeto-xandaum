class CreateDeputyExternalMandates < ActiveRecord::Migration[8.0]
  def change
    create_table :deputy_external_mandates do |t|
      # Basic information
      t.string :position # Cargo (e.g., "Vereador(a)")
      t.string :state_acronym # Sigla do estado (e.g., "AP")
      t.string :municipality # Município (e.g., "Macapá")
      t.integer :start_year # Ano de início (e.g., 2009)
      t.integer :end_year # Ano de término (e.g., 2016)
      t.string :election_party_acronym # Sigla do partido na eleição (e.g., "PMDB")

      # Foreign key to associate the external mandates with a deputy
      t.references :deputy, null: false, foreign_key: true

      # Timestamps
      t.timestamps
    end

    # Adding indexes for searchable fields
    add_index :deputy_external_mandates, :state_acronym
    add_index :deputy_external_mandates, :municipality
    add_index :deputy_external_mandates, :election_party_acronym
  end
end
