class CreateDeputySpeeches < ActiveRecord::Migration[8.0]
  def change
    create_table :deputy_speeches do |t|
      # Basic speech data
      t.string :start_time # Start time of the speech (e.g., "2025-03-12T18:12")
      t.string :end_time # End time of the speech (e.g., nil)
      t.string :event_uri # URI of the event (e.g., "")
      t.string :speech_type # Type of speech (e.g., "DISCUSSÃO" or "BREVES COMUNICAÇÕES")
      t.string :text_url # URL of the speech text (e.g., "https://imagem.camara.gov.br/dc_20b.asp?...")
      t.string :audio_url # URL of the speech audio (e.g., nil)
      t.string :video_url # URL of the speech video (e.g., nil)
      t.string :keywords # Keywords related to the speech (e.g., nil)
      t.text :summary # Summary of the speech (e.g., "O Deputado Chico Alencar abordou a atual situação econômica...")
      t.text :transcription # Full transcription of the speech (e.g., "O SR. CHICO ALENCAR (Bloco/PSOL - RJ. Sem revisão do orador.) - Eu vou cumprir o Regimento...")

      # Event phase data (stored as JSON)
      t.json :event_phase, default: {} # E.g., { "titulo": "Ordem do Dia", "dataHoraInicio": nil, "dataHoraFim": nil }

      # Foreign key to associate the expense with a deputy
      t.references :deputy, null: false, foreign_key: true

      # Timestamps
      t.timestamps
    end

    # Adding indexes for searchable fields
    add_index :deputy_speeches, :start_time
  end
end
