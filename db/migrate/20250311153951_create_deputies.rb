class CreateDeputies < ActiveRecord::Migration[8.0]
  def change
    create_table :deputies do |t|
      # Basic deputy data
      t.string :external_id, null: false # External ID (e.g., 74171)
      t.string :legal_name # Legal name (e.g., "FRANCISCO RODRIGUES DE ALENCAR FILHO")
      t.string :cpf # CPF (e.g., "26451379700")
      t.string :gender # Gender (e.g., "M")
      t.string :website_url # Website URL (e.g., nil)
      t.date :birthdate # Birthdate (e.g., "1949-10-19")
      t.date :death_date # Death date (e.g., nil)
      t.string :birth_state # State of birth (e.g., "RJ")
      t.string :birth_city # City of birth (e.g., "Rio de Janeiro")
      t.string :education_level # Education level (e.g., "Mestrado")

      # Last status data
      t.string :name # Deputy name (e.g., "Chico Alencar")
      t.bigint :party_id # Party ID (e.g., 1)
      t.string :state_acronym # State acronym (e.g., "RJ")
      t.string :legislature_external_id # Legislature ID (e.g., 57)
      t.string :photo_url # Photo URL (e.g., "https://www.camara.leg.br/internet/deputado/bandep/74171.jpg")
      t.string :email # Email (e.g., nil)
      t.date :status_date # Status date (e.g., "2023-02-01")
      t.string :electoral_name, null: false # Electoral name (e.g., "Chico Alencar")
      t.string :status # Status (e.g., "Exercício")
      t.string :electoral_status # Electoral status (e.g., "Titular")
      t.string :status_description # Status description (e.g., nil)

      # Cabinet data (stored as JSON)
      t.json :cabinet, default: {} # E.g., { "nome": "970", "predio": "3", "sala": "970", "andar": nil, "telefone": "3215-5970", "email": "dep.chicoalencar@camara.leg.br" }

      # Social media (stored as an array of strings)
      t.json :social_medias, default: [] # E.g., ["https://twitter.com/depchicoalencar", "https://www.facebook.com/chicoalencar", "https://www.instagram.com/chico.alencar"]

      # Default Rails timestamps
      t.timestamps
    end

    # Adding indexes for unique and searchable fields
    add_index :deputies, :external_id, unique: true
    add_index :deputies, :electoral_name
    add_index :deputies, :party_id
  end
end
