class CreateParties < ActiveRecord::Migration[8.0]
  def change
    create_table :parties do |t|
      # Basic party data
      t.string :external_id, null: false # External ID (e.g., 36899)
      t.string :party_acronym # Party Acronym (e.g., "MDB")
      t.string :party_name # Pary Name (e.g., "Movimento Democrático Brasileiro")

      t.timestamps
    end

    # Adding index for External ID
    add_index :parties, :external_id
  end
end
