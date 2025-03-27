class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      # Basic identification
      t.integer :external_id, null: false # External ID (e.g., 75320)

      # Date and time
      t.datetime :start_time              # Starting date/time (e.g., "2025-03-19T11:06")
      t.datetime :end_time                # Ending date/time (e.g., "2025-03-19T12:04")

      # Event information
      t.string :status                    # Situação (e.g., "Encerrada (Final)"
      t.string :event_type                # Tipo de evento (e.g., "Reunião de Instalação e Eleição")
      t.text :description                 # Detailed description

      # Location
      t.string :external_location         # External venue
      t.json :chamber_location            # Chamber's Location (e.g., { "nome": "Anexo II, Plenário 02" })

      # Media
      t.string :recording_url             # Record URL (e.g., "https://www.youtube.com/watch?v=u6NGG7IWezw")

      # Relationships (stored as JSON)
      t.json :organs                      # Related organs (array of objects)

      # Timestamps
      t.timestamps
    end

    # Indexes
    add_index :events, :external_id, unique: true
    add_index :events, :start_time
    add_index :events, :event_type
  end
end
