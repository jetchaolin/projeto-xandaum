class CreateVoteOrientations < ActiveRecord::Migration[8.0]
  def change
    create_table :vote_orientations do |t|
      # Informações básicas
      t.string :vote_orientation                            # e.g., "Obstrução"
      t.string :leadership_type_code                        # e.g., "B" (código do tipo de liderança)

      # Dados do partido/bloco
      t.string :party_bloc_acronym, null: false             # e.g., "Minoria"
      t.integer :party_bloc_code                            # Código numérico (pode ser nulo)
      t.string :party_bloc_uri                              # URI do partido/bloco

      # Timestamps automáticos
      t.timestamps
    end

    # Índices para otimização
    add_index :vote_orientations, :vote_orientation
    add_index :vote_orientations, :leadership_type_code
    add_index :vote_orientations, :party_bloc_acronym
  end
end
