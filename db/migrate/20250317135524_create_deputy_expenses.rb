class CreateDeputyExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      # Basic expense data
      t.integer :year, null: false # Year of the expense (e.g., 2024)
      t.integer :month, null: false # Month of the expense (e.g., 9)
      t.string :expense_type # Type of expense (e.g., "MANUTENÇÃO DE ESCRITÓRIO DE APOIO À ATIVIDADE PARLAMENTAR")
      t.bigint :document_code, null: false # Document code (e.g., 7818788)
      t.string :document_type # Type of document (e.g., "Nota Fiscal")
      t.integer :document_type_code # Document type code (e.g., 0)
      t.datetime :document_date # Document date (e.g., "2024-09-23T00:00:00")
      t.string :document_number # Document number (e.g., "756")
      t.decimal :document_value, precision: 10, scale: 2 # Document value (e.g., 850.0)
      t.string :document_url # Document URL (e.g., "https://www.camara.leg.br/cota-parlamentar/documentos/publ/1557/2024/7818788.pdf")
      t.string :supplier_name # Supplier name (e.g., "BROAD BRASIL LTDA")
      t.string :supplier_cnpj_cpf # Supplier CNPJ/CPF (e.g., "48949641000113")
      t.decimal :net_value, precision: 10, scale: 2 # Net value (e.g., 850.0)
      t.decimal :gloss_value, precision: 10, scale: 2 # Gloss value (e.g., 0.0)
      t.string :reimbursement_number # Reimbursement number (e.g., "")
      t.bigint :batch_code # Batch code (e.g., 2082763)
      t.integer :installment # Installment (e.g., 0)

      # Foreign key to associate the expense with a deputy
      t.references :deputy, null: false, foreign_key: true

      # Timestamps
      t.timestamps
    end

    # Adding indexes for searchable fields
    add_index :expenses, :year
    add_index :expenses, :month
    add_index :expenses, :document_code
  end
end
