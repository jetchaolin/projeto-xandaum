class Camara::V2::DeputyExpenseAdapter
  def self.call(array, deputy_id)
    filtered_data = array
    if !filtered_data.nil?
      filtered_data.map do |item|
        Deputy.find_by(external_id: deputy_id)
        .deputy_expenses.find_or_initialize_by(document_code: item["codDocumento"])
        .update({
          year: item["ano"], # Year of the expense (e.g., 2024)
          month: item["mes"], # Month of the expense (e.g., 9)
          expense_type: item["tipoDespesa"], # Type of expense (e.g., "MANUTENÇÃO DE ESCRITÓRIO DE APOIO À ATIVIDADE PARLAMENTAR")
          document_code: item["codDocumento"], # Document code (e.g., 7818788)
          document_type: item["tipoDocumento"], # Type of document (e.g., "Nota Fiscal")
          document_type_code: item["codTipoDocumento"], # Document type code (e.g., 0)
          document_date: item["dataDocumento"], # Document date (e.g., "2024-09-23T00:00:00")
          document_number: item["numDocumento"], # Document number (e.g., "756")
          document_value: item["valorDocumento"], # Document value (e.g., 850.0)
          document_url: item["urlDocumento"], # Document URL (e.g., "https://www.camara.leg.br/cota-parlamentar/documentos/publ/1557/2024/7818788.pdf")
          supplier_name: item["nomeFornecedor"], # Supplier name (e.g., "BROAD BRASIL LTDA")
          supplier_cnpj_cpf: item["cnpjCpfFornecedor"], # Supplier CNPJ/CPF (e.g., "48949641000113")
          net_value: item["valorLiquido"], # Net value (e.g., 850.0)
          gloss_value: item["valorGlosa"], # Gloss value (e.g., 0.0)
          reimbursement_number: item["numRessarcimento"], # Reimbursement number (e.g., "")
          batch_code: item["codLote"], # Batch code (e.g., 2082763)
          installment: item["parcela"] # Installment (e.g., 0)
        }.compact_blank)
      end
    end
  end
end
