class Camara::V2::DeputyExternalMandatesAdapter
  def self.call(array, deputy_id)
    filtered_data = array
    if filtered_data != nil
      filtered_data.map do |item|
        Deputy.find_by(external_id: deputy_id)
        .deputy_external_mandates.find_or_initialize_by(start_year: item["anoInicio"])
        .update({
          position: item["cargo"], # Position (e.g., "Vereador(a)")
          state_acronym: item["siglaUf"], # State acronym (e.g., "AP")
          municipality: item["municipio"], # Municipality (e.g., "Macapá")
          start_year: item["anoInicio"], # Start year (e.g., 2009)
          end_year: item["anoFim"], # End year (e.g., 2016)
          election_party_acronym: item["siglaPartidoEleicao"], # Election party acronym (e.g., "PMDB")
        }.compact_blank)
      end
    end
  end
end
