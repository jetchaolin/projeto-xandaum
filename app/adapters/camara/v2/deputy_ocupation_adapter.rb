class Camara::V2::DeputyOcupationAdapter
  def self.call(json, deputy_id)
    filtered_data = json
    filtered_data.map do |item|
      # Busca ou inicializa uma profissão com base no código do tipo de profissão
      Deputy.find_by(external_id: deputy_id)
      .deputy_ocupations.find_or_initialize_by(start_year: item["anoInicio"])
      .update({
        title: item["titulo"], # Title (e.g., "Professor de Prática de Ensino de História")
        entity: item["entidade"], # Name of the entity
        entity_state: item["entidadeUF"], # Entity state (e.g., "RJ")
        entity_country: item["entidadePais"], # Entity country (e.g., "BRASIL")
        end_year: item["anoFim"] # End year (e.g., 1998)
      }.compact_blank) # Remove white spaces
    end
  end
end
