class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      # Identificação básica
      t.string :external_id, null: false  # e.g., "2454687-21"
      t.date :date          # e.g., "2025-03-26"
      t.datetime :registration_datetime  # e.g., "2025-03-26T16:19:28"

      # Orgão relacionado
      t.string :organ_acronym            # e.g., "CPASF"
      t.integer :organ_id                # e.g., 539387

      # Relacionamentos
      t.integer :event_id                # e.g., 75668

      # Resultado da votação
      t.text :description                # e.g., "Aprovado o Parecer."
      t.integer :approval_type           # e.g., 1 (código do tipo de aprovação)

      # Informações de abertura
      t.text :last_opening_description   # Descrição da última abertura
      t.datetime :last_opening_datetime  # Data/hora da última abertura

      # Última proposição apresentada (armazenada como JSON)
      t.json :last_proposition           # e.g., {"dataHoraRegistro"=>"2024-12-02T14:51:41", ...}

      # Efeitos registrados (array de strings)
      t.json :registered_effects, default: []

      # Proposições relacionadas (array de objetos JSON)
      t.json :possible_objects           # e.g., [{"id"=>2478654, "siglaTipo"=>"RPD", ...}]
      t.json :affected_propositions      # e.g., [{"id"=>2454687, "siglaTipo"=>"PL", ...}]

      # Timestamps automáticos
      t.timestamps
    end

    # Índices para otimização
    add_index :votes, :external_id, unique: true
    add_index :votes, :date
    add_index :votes, :organ_id
    add_index :votes, :event_id
    add_index :votes, :approval_type
  end
end
