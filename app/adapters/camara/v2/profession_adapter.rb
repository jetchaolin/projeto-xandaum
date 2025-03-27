class Camara::V2::ProfessionAdapter
  def self.call(json, deputy_id)
    filtered_data = json
    filtered_data.map do |item|
      # Busca ou inicializa uma profissão com base no código do tipo de profissão
      Deputy.find_by(external_id: deputy_id)
      .professions.find_or_initialize_by(profession_type_code: item["codTipoProfissao"])
      .update({
        datetime: item["dataHora"], # Data e hora (e.g., "2018-08-14T16:36")
        title: item["titulo"] # Título da profissão (e.g., "Escritor")
      }.compact_blank) # Remove valores em branco
    end
  end
end
