class CreateDeputyHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :deputy_histories do |t|
      # Basic information
      t.integer :external_id, null: false # ID of the parliamentarian (e.g., 204379)
      t.string :party_acronym # Party acronym (e.g., "PROS")
      t.string :state_acronym # State acronym (e.g., "AP")
      t.integer :legislature_id # Legislature ID (e.g., 56)
      t.string :photo_url # Photo URL (e.g., "https://www.camara.leg.br/internet/deputado/bandep/204379.jpg")
      t.datetime :datetime # Date and time (e.g., "2019-02-01T00:00")
      t.string :status # Status (e.g., "Exercício")
      t.string :electoral_condition # Electoral condition (e.g., "Titular")
      t.text :status_description # Status description (e.g., "Nome no início da legislatura / Partido no início da legislatura")

      # Foreign key to associate the history with a deputy
      t.references :deputy, null: false, foreign_key: true

      # Timestamps
      t.timestamps
    end

    # Adding indexes for searchable fields
    add_index :deputy_histories, :external_id, unique: true
    add_index :deputy_histories, :party_acronym
    add_index :deputy_histories, :state_acronym
  end
end
